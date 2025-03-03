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

########### 修改默认 IP ###########
# sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

########### 设置密码为空（可选） ###########
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

########### 更改大雕源码（可选）###########
sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=6.1/g' target/linux/x86/Makefile

########### 更改默认主题（可选）###########
# 删除自定义源默认的 argon 主题
# rm -rf package/lean/luci-theme-argon
# 拉取 argon 原作者的源码
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
# 替换默认主题为 luci-theme-argon
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile
# make menuconfig时记得勾选LuCI ---> Applications ---> luci-app-argon-config

########### 添加immortal的upx包 ###########
rm -rf package/lean/upx/
svn co https://github.com/immortalwrt/packages/trunk/utils/upx package/lean/upx/
rm -rf package/lean/upx/.svn/
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.0.2/g' package/lean/upx/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=skip/g' package/lean/upx/Makefile

########### 更新lean的内置的smartdns版本 ###########
sed -i 's/1.2023.41/1.2023.42/g' feeds/packages/net/smartdns/Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=0340d272c3e7a618a5b605d7daf8ab07901ab63a/g' feeds/packages/net/smartdns/Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=skip/g' feeds/packages/net/smartdns/Makefile

########### 维持xray-core的版本 ###########
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.8.0/g' feeds/passwall_packages/xray-core/Makefile
# sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/passwall_packages/xray-core/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=skip/g' feeds/passwall_packages/xray-core/Makefile

########### 维持xray-plugin的版本 ###########
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.8.0/g' feeds/passwall_packages/xray-plugin/Makefile
# sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/passwall_packages/xray-plugin/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=skip/g' feeds/passwall_packages/xray-plugin/Makefile

########### 安装msd_lite ###########
rm -rf feeds/packages/net/msd_lite
git clone https://github.com/ximiTech/msd_lite.git feeds/packages/net/msd_lite

########### 安装sing-box ###########
rm -rf feeds/passwall_packages/sing-box
svn co https://github.com/immortalwrt/packages/trunk/net/sing-box feeds/passwall_packages/sing-box/
sed -i '44c include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk' feeds/passwall_packages/sing-box/Makefile

########### 安装luci-theme-argon ###########
rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon

rm -rf feeds/luci/applications/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/applications/luci-app-argon-config
