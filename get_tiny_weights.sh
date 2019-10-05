#!/bin/bash

wget https://pjreddie.com/media/files/yolov3-tiny.weights
wget https://raw.githubusercontent.com/AlexeyAB/darknet/master/cfg/yolov3-tiny_obj.cfg
mv yolov3-tiny_obj.cfg cfg/
./darknet partial cfg/yolov3-tiny_obj.cfg yolov3-tiny.weights yolov3-tiny.conv.15 15
rm yolov3-tiny.weights
#cp cfg/yolov3-tiny_obj.cfg yolov3-tiny-obj.cfg
