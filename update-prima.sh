#!/bin/bash
if [ $# -eq 1 ]; then
    TAG=$1
  else
    echo "$0: bad number of arguments"
    echo ""
    echo "usage: $0 [CAF TAG]"
    exit 1
fi

rm -rf drivers/staging/prima
git clone https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/prima/ -b $1 --depth=1 drivers/staging/prima
rm -rf drivers/staging/prima/.git
git checkout HEAD -- drivers/staging/prima/Kconfig
