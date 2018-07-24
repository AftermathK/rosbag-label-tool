#!/bin/bash

if [ "$1" == "" ]; then
    echo "Usage: ./rosbag_label.sh [Path to ROSBAG]"
    exit $?
fi

ROS_BAG=$1
#Extract name up to the first period
FILE_NAME=(${ROS_BAG//./ })

echo "Location: " 
read LOCATION

echo "Type (Calibration, Mapping, Testing, etc): "
read COLLECT_TYPE

echo "Light/Weather Conditions: "
read CONDITIONS 

echo "Scenarios (Stop Sign Detection, Avoidance of Obstacle, etc): "
read SCENARIOS

echo "Driver: "
read DRIVER

echo "Co-pilot: "
read COPILOT

echo "Vehicle Number/Name: "
read VEHICLE

echo "Additional Notes: "
read NOTES

NEW_FILE_NAME=$FILE_NAME"_"$LOCATION"_"$COLLECT_TYPE"_"$VEHICLE".bag"
#Rename the ROSBAG
python rename_bag_file.py $FILE_NAME $LOCATION $COLLECT_TYPE $VEHICLE
TEXT_FILE_GEN=$FILE_NAME"_"$LOCATION"_"$COLLECT_TYPE"_"$VEHICLE".txt"

#Get information from ROSBAG and save it in a text file
echo "Location: "$LOCATION > $TEXT_FILE_GEN
echo "Type of BAG file: "$COLLECT_TYPE >> $TEXT_FILE_GEN
echo "Weather/Light Conditions: "$CONDITIONS >> $TEXT_FILE_GEN
echo "Scenarios: "$SCENARIOS >> $TEXT_FILE_GEN
echo "Driver: "$DRIVER >> $TEXT_FILE_GEN
echo "Co-pilot: "$COPILOT >> $TEXT_FILE_GEN
echo "Vehicle: "$VEHICLE >> $TEXT_FILE_GEN
echo "Additional Notes: "$NOTES >> $TEXT_FILE_GEN
echo "---------------------ROSBAG INFO-------------------------" >> $TEXT_FILE_GEN
rosbag info $NEW_FILE_NAME >> $TEXT_FILE_GEN






