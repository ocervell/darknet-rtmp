#!/bin/bash

if [ -z "$MODEL" ]; then
  MODEL=obj
fi;

DATA=$MODEL.data
CFG=$MODEL.cfg

if [ -z "$WEIGHT_PATH" ]; then
  WEIGHTS=backup/${MODEL}_$1.weights
else
  WEIGHTS=$WEIGHT_PATH
fi;

echo "Model: $MODEL"
echo "Datafile: $DATA"
echo "Config: $CFG"
echo "Weights: $WEIGHTS"

./darknet detector train $DATA $CFG $WEIGHTS -dont_show -map
