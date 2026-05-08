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


git clone https://github.com/tty228/luci-app-wechatpush package/myapp/luci-app-wechatpush
git clone https://github.com/yaof2/luci-app-ikoolproxy package/myapp/luci-app-ikoolproxy
git clone https://github.com/destan19/OpenAppFilter.git package/myapp/OpenAppFilter
git clone https://github.com/xiaoxiao29/luci-app-adguardhome package/myapp/luci-app-adguardhome
#git clone https://github.com/sirpdboy/luci-app-watchdog package/myapp/luci-app-watchdog&&chmod -R 777 package/myapp/luci-app-watchdog
#git clone https://github.com/sirpdboy/luci-app-eqosplus package/myapp/luci-app-eqosplus&&chmod -R 777 package/myapp/luci-app-eqosplus
git clone https://github.com/liwenjie119/luci-app-v2ray-server package/myapp/luci-app-v2ray-server

#增加版本日期
current_time=$(TZ=UTC-8 date +"%Y-%m-%d %H:%M:%S")
sed -i "s/\(DISTRIB_REVISION='\([^']*\)\)'/\1 $current_time'/" package/lean/default-settings/files/zzz-default-settings
