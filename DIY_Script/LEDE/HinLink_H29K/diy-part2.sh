#!/bin/bash
sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/luci2/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/luci2/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#mv $GITHUB_WORKSPACE/patch/lean/mac80211.sh package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/lean/199-rockchip.sh package/base-files/files/etc/uci-defaults/zz-rockchip.sh
sed -i '/openwrt_release/d' package/lean/default-settings/files/zzz-default-settings
#sed -i '/shadow/d' package/lean/default-settings/files/zzz-default-settings
sed -i 's#mirrors.tencent.com/lede#mirrors.pku.edu.cn/immortalwrt#g' package/lean/default-settings/files/zzz-default-settings

rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd*,miniupnpd-iptables,wireless-regdb,luci-theme-argon}
rm -rf feeds/luci/applications/{luci-app-alist,luci-app-adguardhome,luci-app-mosdns,luci-app-smartdns}
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,v2ray*,sing*,smartdns}
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
git clone --depth 1 https://github.com/fw876/helloworld.git package/helloworld
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2
git clone -b v5-lua https://github.com/sbwml/luci-app-mosdns package/mosdns
#git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    mv package/openclash-core/master/meta/clash-linux-arm64.tar.gz package/base-files/files/etc/clash-linux-arm64.tar.gz
    rm -rf package/openclash-core
fi

git clone --depth=1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/luci-app-chatgpt-web package/luci-app-chatgpt-web
mv package/kz8-small/luci-app-eqosplus package/luci-app-eqosplus
mv package/kz8-small/iptvhelper package/iptvhelper
mv package/kz8-small/luci-app-iptvhelper package/luci-app-iptvhelper
mv package/kz8-small/lucky package/lucky
mv package/kz8-small/luci-app-lucky package/luci-app-lucky
mv package/kz8-small/smartdns package/smartdns
mv package/kz8-small/luci-app-smartdns package/luci-app-smartdns
mv package/kz8-small/homebox package/homebox
mv package/kz8-small/luci-app-netspeedtest package/luci-app-netspeedtest
mv package/kz8-small/luci-app-poweroffdevice package/luci-app-poweroffdevice
mv package/kz8-small/luci-app-bypass package/luci-app-bypass
rm -rf package/kz8-small

rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
git clone -b lua --depth 1 https://github.com/sbwml/luci-app-alist.git feeds/luci/themes/luci-app-alist
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git package/luci-app-ddns-go
git clone --depth 1 https://github.com/sirpdboy/luci-app-netdata.git package/luci-app-netdata

git clone --depth 1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth 1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network


