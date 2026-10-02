#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: 2410-6.6-ax3000t-diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#   小米 AX3000T / immortalwrt-mt798x-6.6 / MTK U-Boot (112M) 定制
#
# 说明：默认登录地址 192.168.6.1、主机名 ImmortalWrt 都是 237 源码的默认值，
#       本机型不需要改动，所以这里只做「固件文件名前缀」一件事。
#

set -e

# ---- 固件文件名加日期前缀（$(shell ...) 在 include/image.mk 里会被 make 展开，有效）----
# 例：20260815-AX3000T-24.10-6.6-immortalwrt-mediatek-filogic-xiaomi_mi-router-ax3000t-mtkuboot-squashfs-factory.bin
if grep -q '^IMG_PREFIX:=' include/image.mk; then
	sed -i 's|IMG_PREFIX:=|IMG_PREFIX:=$(shell TZ="Asia/Shanghai" date +"%Y%m%d")-AX3000T-24.10-6.6-|' include/image.mk
	echo "[diy-part2] IMG_PREFIX 已改为：$(grep '^IMG_PREFIX:=' include/image.mk)"
else
	echo "[diy-part2] 警告：include/image.mk 里没找到 IMG_PREFIX:=，跳过改名"
fi

# ---- 想让 Argon 成为默认主题时，取消下面这行的注释 ----
# （luci-theme-argon 已经在 .config 里选中，编进固件了；不启用也能在 系统→系统→语言和界面 里切换）
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# ---- 想改默认 IP / 主机名时，参考下面两行（本机型默认不需要）----
# sed -i 's/192.168.6.1/192.168.1.1/g' package/base-files/files/bin/config_generate
# sed -i 's/ImmortalWrt/AX3000T/g' package/base-files/files/bin/config_generate

echo "[diy-part2] done."
