#!/bin/bash

CLASSES=$(wc -l $MODEL.names)
WIDTH=608
HEIGHT=608

echo "Setting classes=$CLASSES"
sed -i "s/classes=.*/classes=$CLASSES/g" $MODEL.cfg

echo "Setting random=1"
sed -i "s/random=0/random=1/g" $MODEL.cfg

echo "Setting width=$WIDTH and height=$HEIGHT"
sed -i "Increasing network resolution to $WIDTH * $HEIGHT"
