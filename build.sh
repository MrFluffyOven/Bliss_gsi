#!/bin/bash

echo
echo "--------------------------------------"
echo "             Rebuild Only             "       
echo "--------------------------------------"
echo

set -e

BL=$PWD/treble_bliss
BD=$HOME/builds

setupEnv() {
    echo "--> Setting up build environment"
    source build/envsetup.sh &>/dev/null
    mkdir -p $BD
    echo
}

buildVanillaVariant() {
    echo "--> Building treble_arm64_bvN"
    lunch treble_arm64_bvN-userdebug
    make -j4 installclean
    make -j4 systemimage
    mv $OUT/system.img $BD/system-treble_arm64_bvN.img
    echo
}

buildGappsVariant() {
    echo "--> Building treble_arm64_bgN"
    lunch treble_arm64_bgN-userdebug
    make -j4 installclean
    make -j4 systemimage
    mv $OUT/system.img $BD/system-treble_arm64_bgN.img
    echo
}

buildVndkliteVariants() {
    echo "--> Building treble_arm64_bvN-vndklite"
    cd treble_adapter
    sudo bash lite-adapter.sh 64 $BD/system-treble_arm64_bvN.img
    mv s.img $BD/system-treble_arm64_bvN-vndklite.img
    sudo rm -rf d tmp

    echo "--> Building treble_arm64_bgN-vndklite"
    sudo bash lite-adapter.sh 64 $BD/system-treble_arm64_bgN.img
    mv s.img $BD/system-treble_arm64_bgN-vndklite.img
    sudo rm -rf d tmp
    cd ..
    echo
}

generatePackages() {
    echo "--> Generating packages"
    buildDate="$(date +%Y%m%d)"
    xz -cv $BD/system-treble_arm64_bvN.img -T0 > $BD/bliss-arm64-ab-vanilla-14.0-$buildDate.img.xz
    xz -cv $BD/system-treble_arm64_bvN-vndklite.img -T0 > $BD/bliss-arm64-ab-vanilla-vndklite-14.0-$buildDate.img.xz
    xz -cv $BD/system-treble_arm64_bgN.img -T0 > $BD/bliss-arm64-ab-gapps-14.0-$buildDate.img.xz
    xz -cv $BD/system-treble_arm64_bgN-vndklite.img -T0 > $BD/bliss-arm64-ab-gapps-vndklite-14.0-$buildDate.img.xz
    rm -rf $BD/system-*.img
    echo
}


START=$(date +%s)

setupEnv
buildTrebleApp
buildVanillaVariant
buildGappsVariant
buildVndkliteVariants
generatePackages

END=$(date +%s)
ELAPSEDM=$(($(($END-$START))/60))
ELAPSEDS=$(($(($END-$START))-$ELAPSEDM*60))

echo "--> Buildbot completed in $ELAPSEDM minutes and $ELAPSEDS seconds"
echo
