#!/bin/bash

echo
echo "--------------------------------------"
echo "           Applying Patches           "       
echo "--------------------------------------"
echo

set -e

BL=$PWD/treble_bliss
BD=$HOME/builds

applyPatches() {
    echo "--> Applying TrebleDroid patches"
    bash $BL/patch.sh $BL trebledroid
    echo

    echo "--> Applying personal patches"
    bash $BL/patch.sh $BL personal
    echo
}

START=$(date +%s)

applyPatches

END=$(date +%s)
ELAPSEDM=$(($(($END-$START))/60))
ELAPSEDS=$(($(($END-$START))-$ELAPSEDM*60))

echo "--> Buildbot completed in $ELAPSEDM minutes and $ELAPSEDS seconds"
echo