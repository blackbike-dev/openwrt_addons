#
# Copyright (C) 2026 Richard Smith
# Copyright (C) 2016 Toke Høiland-Jørgensen
#
# This is free software, licensed under the GNU General Public License v3 or later
#

include $(TOPDIR)/rules.mk

PKG_NAME:=acme-acmesh
PKG_VERSION:=3.1.1
PKG_RELEASE:=2

PKG_BUILD_DIR:=$(BUILD_DIR)/acme.sh-$(PKG_VERSION)

#PKG_MAINTAINER:=Toke Høiland-Jørgensen <toke@toke.dk>
PKG_MAINTAINER:=Richard Smith <blackbike-dev@gmail.com>
PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE.md

include $(INCLUDE_DIR)/package.mk

define Package/acme-acmesh
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Openwrt_Addons
  DEPENDS:=+acme-common +wget-ssl +ca-bundle +openssl-util +socat
  TITLE:=ACME client acme.sh wrapper script
  PKGARCH:=all
  PROVIDES:=acme-client
endef

define Package/acme-acmesh/description
A client for issuing ACME (e.g, Letsencrypt) certificates.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/acme-acmesh/install
	$(INSTALL_DIR) $(1)/usr/lib/acme/client
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/acme.sh $(1)/usr/lib/acme/client
	$(INSTALL_BIN) ./files/hook.sh $(1)/usr/lib/acme/hook
endef

define Package/acme-acmesh-dnsapi
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+acme-acmesh
  TITLE:=DNS API integration for ACME (Letsencrypt) client
  PKGARCH:=all
endef

define Package/acme-acmesh-dnsapi/description
 This package provides DNS API integration for ACME (Letsencrypt) client.
endef

define Package/acme-acmesh-dnsapi/install
	$(INSTALL_DIR) $(1)/usr/lib/acme/client/dnsapi
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/dnsapi/*.sh $(1)/usr/lib/acme/client/dnsapi
endef

$(eval $(call BuildPackage,acme-acmesh))
$(eval $(call BuildPackage,acme-acmesh-dnsapi))
