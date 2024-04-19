#!/bin/bash

echo
echo "--------------------------------------"
echo "          Generate Makefiles          "       
echo "--------------------------------------"
echo

set -e

BL=$PWD/treble_bliss
BD=$HOME/builds

generate() {
    echo "--> Generating makefiles"
    cd device/phh/treble
    cp $BL/bliss.mk .
    bash generate.sh bliss
    cd ../../..
    echo
}

START=$(date +%s)

generate

END=$(date +%s)
ELAPSEDM=$(($(($END-$START))/60))
ELAPSEDS=$(($(($END-$START))-$ELAPSEDM*60))

echo "--> Buildbot completed in $ELAPSEDM minutes and $ELAPSEDS seconds"
echo
