#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
set -e

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "${SCRIPT_DIR}"

PATCH_DATA=$(cat <<'ENDPATCH'
diff --git a/openwrt/feeds/packages/net/frp/Makefile b/openwrt/feeds/packages/net/frp/Makefile
index 2737fed..3dffe50 100644
--- a/openwrt/feeds/packages/net/frp/Makefile
+++ b/openwrt/feeds/packages/net/frp/Makefile
@@ -12,7 +12,7 @@ PKG_MAINTAINER:=Alexandru Ardelean <ardeleanalex@gmail.com>
 PKG_LICENSE:=Apache-2.0
 PKG_LICENSE_FILES:=LICENSE
 
-PKG_BUILD_DEPENDS:=golang/host node/host
+PKG_BUILD_DEPENDS:=golang/host
 PKG_BUILD_PARALLEL:=1
 PKG_USE_MIPS16:=0
 PKG_BUILD_FLAGS:=no-mips16
@@ -25,13 +25,18 @@ GO_PKG_LDFLAGS_X:=$(GO_PKG)/pkg/util/version.version=$(PKG_VERSION)
 include $(INCLUDE_DIR)/package.mk
 include ../../lang/golang/golang-package.mk
 
+define Build/Prepare
+	$(call Build/Prepare/Default)
+	# 截断文件，只保留前两行
+	echo '//go:build !noweb' > $(PKG_BUILD_DIR)/web/frpc/embed.go
+	echo 'package frpc' >> $(PKG_BUILD_DIR)/web/frpc/embed.go
+
+	echo '//go:build !noweb' > $(PKG_BUILD_DIR)/web/frps/embed.go
+	echo 'package frps' >> $(PKG_BUILD_DIR)/web/frps/embed.go
+endef
+
 define Build/Compile
-	( \
-		$(MAKE) -C $(PKG_BUILD_DIR)/web/frpc install ; \
-		$(MAKE) -C $(PKG_BUILD_DIR)/web/frps install ; \
-		$(MAKE) -C $(PKG_BUILD_DIR) web ; \
-		$(call GoPackage/Build/Compile) ; \
-	)
+	($(call GoPackage/Build/Compile) ; )
 endef
 
 define Package/frp/install
ENDPATCH
)

echo "${PATCH_DATA}" | patch -p1 --no-backup-if-mismatch
echo "✅ frp Makefile inline patch applied"
