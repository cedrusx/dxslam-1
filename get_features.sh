#!/bin/bash -e

for FOLDER in "$@"
do
    python3 Examples/RGB-D/associate_py3.py $FOLDER/rgb.txt $FOLDER/depth.txt > $FOLDER/associations.txt
    wc $FOLDER/associations.txt

    cd hf-net
    python3 getFeature.py $FOLDER/rgb/ $FOLDER/features_hfnet_df
    cd -
done
