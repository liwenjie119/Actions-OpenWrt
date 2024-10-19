#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
#sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
if [ -d 'package/myapp' ]; then
	cd package/myapp/luci-app-adguardhome&&git checkout .&&git pull
	cd ../zzu-minieap-openwrt&&git checkout .&&git pull
	cd ../luci-app-ikoolproxy&&git checkout .&&git pull
	cd ../OpenAppFilter&&git checkout .&&git pull
	cd ../luci-app-v2ray-server&&git checkout .&&git pull
	#cd ../luci-app-argon-config&&git checkout .&&git pull
	#cd ../luci-theme-argon&&git checkout .&&git pull
	cd ../../../
else
git clone https://github.com/kongfl888/luci-app-adguardhome package/myapp/luci-app-adguardhome
git clone https://github.com/2512500960/zzu-minieap-openwrt package/myapp/zzu-minieap-openwrt
#git clone https://github.com/tty228/luci-app-serverchan package/myapp/luci-app-serverchan
git clone https://github.com/yaof2/luci-app-ikoolproxy package/myapp/luci-app-ikoolproxy
git clone https://github.com/destan19/OpenAppFilter.git package/myapp/OpenAppFilter
#git clone https://github.com/liwenjie119/luci-app-v2ray-server package/myapp/luci-app-v2ray-server
#luci-theme-argon
#rm -rf feeds/luci/themes/luci-theme-argon  
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/myapp/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config package/myapp/luci-app-argon-config
fi


#x86
#虚拟机升级受影响，暂时取消
#sed -i 's/PADDING="1"//g' target/linux/x86/image/Makefile
