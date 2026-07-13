# SPDX-License-Identifier: MIT
#
# Copyright (C) 2026 openwrt_addons

include $(TOPDIR)/rules.mk

PKG_NAME:=openwrt_addons_keyring
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_MAINTAINER:=Richard Smith <rtsmith134@gmail.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=License

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=base
  CATEGORY:=Base system
  TITLE:=openwrt-addons-packages Developer Keyring
  PKGARCH:=all
endef

define Package/$(PKG_NAME)/description
  The keyring of with the developer using.
endef

Build/Compile=

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/opkg/keys/
	$(INSTALL_DATA) $(CURDIR)/usign/870A1D7EB2240B92 $(1)/etc/opkg/keys/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
