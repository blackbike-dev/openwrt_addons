# SPDX-License-Identifier: MIT
#
# Copyright (C) 2023-2025 fantastic-packages
# Copyright (C) 2026 openwrt-packages

include $(TOPDIR)/rules.mk

PKG_NAME:=openwrt-packages-feeds
PKG_VERSION:=20250513
PKG_RELEASE:=1

# PKG_MAINTAINER:=Anya Lin <hukk1996@gmail.com>
PKG_MAINTAINER:=Richard Smith <rtsmith771@gmail.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=License

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=base
  CATEGORY:=Base system
  DEPENDS:=+openwrt-keyring +opkg
  TITLE:=Installer for openwrt-packages feeds
  PKGARCH:=all
endef

Build/Compile=

define Package/$(PKG_NAME)/install
	:
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
export REVISION VERSION_NUMBER ARCH_PACKAGES
if [ -n "$$IPKG_INSTROOT" ]; then
	# building
	eval "$$(grep CONFIG_VERSION_NUMBER "$$TOPDIR/.config")"
	eval "$$(grep CONFIG_VERSION_REPO "$$TOPDIR/.config")"
	eval "$$(grep CONFIG_TARGET_ARCH_PACKAGES "$$TOPDIR/.config")"
	REVISION=$$($$TOPDIR/scripts/getver.sh)
	REVISION=$${REVISION:1:5}
	if [ -n "$$CONFIG_VERSION_REPO" ]; then
		VERSION_NUMBER=$${CONFIG_VERSION_REPO##*/}
	else
		VERSION_NUMBER=$${CONFIG_VERSION_NUMBER:-SNAPSHOT}
	fi
	ARCH_PACKAGES=$$CONFIG_TARGET_ARCH_PACKAGES
else
	# system
	eval "$$(grep VERSION /etc/os-release)"
	eval "$$(grep BUILD_ID /etc/os-release)"
	eval "$$(grep OPENWRT_ARCH /etc/os-release)"
	REVISION=$${BUILD_ID:1:5}
	VERSION_NUMBER=$$VERSION
	ARCH_PACKAGES=$$OPENWRT_ARCH
fi
if [ "$$VERSION_NUMBER" = "SNAPSHOT" ]; then
	BRANCH="24.10"
	[ "$$REVISION" -lt 28158 ] && BRANCH="23.05"
	[ "$$REVISION" -lt 23069 ] && BRANCH="22.03"
	[ "$$REVISION" -lt 19302 ] && BRANCH="21.02"
	# https://archive.openwrt.org/releases/**/version.buildinfo

else
	BRANCH=$$(echo $$VERSION_NUMBER | awk -F '.' -v OFS='.' '{print $$1,$$2}')
fi
if ! grep -q fantastic_packages_ "$$IPKG_INSTROOT/etc/opkg/customfeeds.conf"; then
	BASE_URL="http://openwrt_addons.home/releases"
	BASE_URL="$$BASE_URL/$$BRANCH/packages/$$ARCH_PACKAGES"
	cat <<- EOF >> "$$IPKG_INSTROOT/etc/opkg/customfeeds.conf"
	src/gz openwrt_packages_packages $$BASE_URL/packages
	src/gz openwrt_packages_luci     $$BASE_URL/luci
	src/gz openwrt_packages_special  $$BASE_URL/special
	EOF
fi
exit 0
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
sed -i "/openwrt_packages_/d" "$$IPKG_INSTROOT/etc/opkg/customfeeds.conf"
exit 0
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
