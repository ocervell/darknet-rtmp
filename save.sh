#!/bin/bash

print_usage(){
  echo "Usage:   ./save.sh <WEIGHT>"
  echo "Example: ./save.sh 28600"
}

if [ -z "archive/${MODEL}" ]; then
   mkdir -p archive/${MODEL}
fi

if [ -z "$MODEL" ]; then
   echo "MODEL must be set."
   exit 1
fi

if [ -z "$1" ]; then
   print_usage
   exit 1
fi

echo "MODEL: $MODEL"
echo "WEIGHT: ${MODEL}_$1.weights"
echo "Saving weight ${MODEL}_$1.weights ..."
cp backup/${MODEL}_$1.weights archive/${MODEL}
