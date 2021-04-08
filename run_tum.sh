#!/bin/bash -e

FOLDER=$1

if [[ "$2" != "" ]]; then
    CONFIG=$2
elif [[ "$FOLDER" == *"freiburg1"* ]]; then
    CONFIG=Examples/RGB-D/TUM1.yaml
elif [[ "$FOLDER" == *"freiburg2"* ]]; then
    CONFIG=Examples/RGB-D/TUM2.yaml
elif [[ "$FOLDER" == *"freiburg3"* ]]; then
    CONFIG=Examples/RGB-D/TUM3.yaml
else
    echo "Usage: $0 DATA_FOLDER CONFIG_FILE"
    exit
fi

if test -f "$FOLDER/associations.txt"; then
    ASSOCIATION=$FOLDER/associations.txt
elif test -f "$FOLDER/association.txt"; then
    ASSOCIATION=$FOLDER/association.txt
else
    echo "Association file not found under $1"
    exit
fi

echo ./Examples/RGB-D/rgbd_tum Vocabulary/DXSLAM.fbow $CONFIG $FOLDER $ASSOCIATION $FOLDER/features_hfnet

./Examples/RGB-D/rgbd_tum Vocabulary/DXSLAM.fbow $CONFIG $FOLDER $ASSOCIATION $FOLDER/features_hfnet
cp CameraTrajectory.txt $1/trajectory-dxslam.txt
evo_ape tum $1/groundtruth.txt $1/trajectory-dxslam.txt -a -p
wc CameraTrajectory.txt
