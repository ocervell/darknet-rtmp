#!/bin/bash

if [ -z "$MODEL" ]; then
  MODEL=obj
fi;

if [ -z "$RTMP_FPS" ]; then
  RTMP_FPS=15
fi;

if [ -z "$RTMP_URL" ]; then
  RTMP_URL=rtmp://localhost:1935/live/test
fi;

if [ -z "$THRESHOLD" ]; then
  THRESHOLD=20
fi;

DATA=$MODEL.data
CFG=$MODEL.cfg
WEIGHTS=backup/${MODEL}_$1.weights

echo "Model: $MODEL"
echo "Datafile: $DATA"
echo "Config: $CFG"
echo "Weights: $WEIGHTS"
echo "RTMP FPS: $RTMP_FPS"
echo "RTMP URL: $RTMP_URL"
echo "Threshold: $THRESHOLD"

./darknet detector demo $DATA $CFG $WEIGHTS -dont_show -rtmp_fps $RTMP_FPS $RTMP_URL -http-port=8090
