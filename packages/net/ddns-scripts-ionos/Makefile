#
# Copyright (C) 2008-2026 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ddns-scripts-ionos
PKG_VERSION:=0.8.0
PKG_RELEASE:=01

PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/ddns-scripts-ionos/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  PKGARCH:=all
endef

define Package/ddns-scripts-ionos
  $(call Package/ddns-scripts-ionos/Default)
  TITLE:=  Extension for IONOS API v4
  DEPENDS:=ddns-scripts +curl
endef

define Package/ddns-scripts-ionos/description
  An Extenstion for ddns-scripts to add support for IONOS API v4
endef

define Package/ddns-scripts-ionos/install
	$(INSTALL_DIR) $(1)/usr/lib/ddns
	$(INSTALL_BIN) ./files/usr/lib/ddns/update_ionos_v1.sh \
		$(1)/usr/lib/ddns

	$(INSTALL_DIR) $(1)/usr/share/ddns/default
	$(INSTALL_DATA) ./files/usr/share/ddns/default/ionos-v1.json \
		$(1)/usr/share/ddns/default/
endef

define Package/ddns-scripts-ionos/prerm
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	/etc/init.d/ddns stop
fi
exit 0
endef

$(eval $(call BuildPackage,ddns-scripts-ionos))

