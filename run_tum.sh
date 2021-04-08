#!/bin/bash -e

FOLDER=$1

if [[ "$FOLDER" == *"freiburg1"* ]]; then
    CONFIG=TUM1.yaml
elif [[ "$FOLDER" == *"freiburg2"* ]]; then
    CONFIG=TUM2.yaml
elif [[ "$FOLDER" == *"freiburg3"* ]]; then
    CONFIG=TUM3.yaml
else
    echo "Usage: $0 DATA_FOLDER CONFIG_FILE"
    exit
fi

echo ./Examples/RGB-D/rgbd_tum Vocabulary/DXSLAM.fbow Examples/RGB-D/$CONFIG $1 $1/associations.txt $1/features_hfnet

./Examples/RGB-D/rgbd_tum Vocabulary/DXSLAM.fbow Examples/RGB-D/$CONFIG $1 $1/associations.txt $1/features_hfnet
cp CameraTrajectory.txt $1/trajectory-dxslam.txt
evo_ape tum $1/groundtruth.txt $1/trajectory-dxslam.txt -a -p
wc CameraTrajectory.txt
