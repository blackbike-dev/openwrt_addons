#
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=qca8k_reg_reader
PKG_VERSION:=0.1
PKG_RELEASE:=1
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_INSTALL:=1

PKG_MAINTAINER:=Richard Smith <rtsmith771@gmail.com>
PKG_LICENSE:=GPL-3.0-or-later



include $(INCLUDE_DIR)/package.mk

define Package/qca8k_reg_reader/Default
  TITLE:=Program to read QCA8337 registers
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+kmod-tun +libpthread +liblzo
endef





define Package/qca8k_reg_reader/description
  Program to read DSA QCA8XXX switch registers
endef


	
CONFIGURE_ARGS += \
	--with-kernel="$(LINUX_DIR)" \
	--with-zlib="$(STAGING_DIR)/usr" \
	--with-lzo-include="$(STAGING_DIR)/usr/include/lzo"
	EXTRA_CFLAGS += -DLINUX -D__KERNEL__ -DMODULE -O2 -pipe -Wall	

define Package/qca8k_reg_reader/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/qca8k_reg_reader $(1)/usr/bin/
endef

$(eval $(call BuildPackage,qca8k_reg_reader))
