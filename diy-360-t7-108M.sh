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

function merge_package(){
    repo=echo $1 | rev | cut -d'/' -f 1 | rev
    pkg=echo $2 | rev | cut -d'/' -f 1 | rev
    git clone --depth=1 --single-branch $1
    mv $2 package/myapp/
    rm -rf $repo
}
rm -rf package/myapp; mkdir package/myapp

# v2ray-server 
merge_package https://github.com/coolsnowwolf/luci luci/applications/luci-app-v2ray-server


# Add a feed source
git clone https://github.com/kongfl888/luci-app-adguardhome package/myapp/luci-app-adguardhome
git clone https://github.com/yaof2/luci-app-ikoolproxy package/myapp/luci-app-ikoolproxy







