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

## 添加额外软件包
#merge_package() {
#	# 参数1是分支名, 参数2是子目录, 参数3是目标目录, 参数4仓库地址
#	trap 'rm -rf "$TMP_DIR"' 0 1 2 3
#	TMP_DIR="$(mktemp -d)" || exit 1
#        ORI_DIR="$PWD"
#	[ -d "$3" ] || mkdir -p "$3"
#	TGT_DIR="$(cd "$3"; pwd)"
#	cd "$TMP_DIR" && \
#	git init >/dev/null 2>&1 && \
#	git remote add -f origin "$4" >/dev/null 2>&1 && \
#	git checkout "remotes/origin/$1" -- "$2" && \
#	cd "$2" && cp -a . "$TGT_DIR/" && cd "$ORI_DIR"
#}
#
#
## v2ray-server 
#merge_package "master" "applications/luci-app-v2ray-server" "package/myapp/luci-app-v2ray-server" "https://github.com/coolsnowwolf/luci"

function merge_package(){
    repo=`echo $1 | rev | cut -d'/' -f 1 | rev`
    pkg=`echo $2 | rev | cut -d'/' -f 1 | rev`
    # find package/ -follow -name $pkg -not -path "package/custom/*" | xargs -rt rm -rf
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







