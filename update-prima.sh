#!/bin/bash
if [ $# -ge 1 ]; then
    TAG=$1
  else
    echo "$0: bad number of arguments"
    echo ""
    echo "usage: $0 [CAF TAG] [-c/--commit (optional)]"
    echo ""
    echo "If --commit flag is used, changes will be"
    echo "automatically committed with a standard"
    echo "commit message format."
    echo ""
    exit 1
fi

rm -rf drivers/staging/prima
git clone https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/wlan/prima/ -b $1 --depth=1 drivers/staging/prima
rm -rf drivers/staging/prima/.git
git checkout HEAD -- drivers/staging/prima/Kconfig

while [ "$2" != "" ]; do
    case $2 in
        -c | --commit )     AUTO_COMMIT=true
                                ;;
    esac
    shift
done

if [ "$AUTO_COMMIT" = "true" ]; then
    echo "--commit flag specified, auto-committing..."
    git add drivers/staging/prima
    git commit -m "staging: prima: Update to $TAG"
fi
