![Darknet Logo](http://pjreddie.com/media/files/darknet-black-small.png)

# YOLO with RTMP support
`You only look once` (YOLO) is a state-of-the-art, real-time object detection system.

This repository extend YOLO to running on RTMP streaming in / out. This means
you can live stream video feeds to your server running Darknet and it will
stream result with detection bounding boxes drawn streamed out via RTMP.

This repository's fork history is:
```bash
├── https://github.com/pjreddie/darknet
│   ├── https://github.com/AlexeyAB/darknet
│   │   ├── https://github.com/MarcoBay/darknet
```

This repo has  the following options set in the `Makefile`:

* `GPU=1` to enable GPU computations (fast !!!)
* `OPENCV=1` to enable OpenCV (tested with OpenCV 3.x and higher).
* `CUDNN=1` to enable CUDA.

Feel free to change those settings at your own peril :)

## Results

*OBS send streaming to RTMP server, server will call darknet(YOLO) to process.
darknet(YOLO) will render to another rtmp streaming.
VLC open the streaming.*

<img src='https://github.com/MarcoBay/darknet-rtmp/raw/master/graphic/vlcsnap-1.png?raw=true' width='473' alt='Demo1'>

<img src='https://github.com/MarcoBay/darknet-rtmp/raw/master/graphic/vlcsnap-2.png?raw=true' width='473' alt='Demo2'>

<img src='https://github.com/MarcoBay/darknet-rtmp/raw/master/graphic/vlcsnap-3.png?raw=true' width='473' alt='Demo3'>


## Prerequisites
This version is optimized to run and has been tested on an NVIDIA GPU
`Tesla P200` on a Google Cloud Compute Engine VM.

The GCE VM can be created with the following gcloud command:

```
gcloud beta compute instances create <INSTANCE_NAME>
--project=<PROJECT_NAME> \
--zone=europe-west1-b \
--machine-type=n1-standard-8 \
--subnet=default \
--network-tier=PREMIUM \
--maintenance-policy=TERMINATE \
--scopes=https://www.googleapis.com/auth/cloud-platform \
--image=c2-deeplearning-tf-1-12-cu100-20181120 \
--image-project=ml-images \
--boot-disk-size=60GB \
--boot-disk-type=pd-standard
```

Configure the GCP firewall rule to let RTMP traffic flow in / out in the GCE VM:

* `allow-tcp-1935` --> Allow incoming / outgoing traffic on port 1935

**Note:** *Once the instance has been started, it will prompt to install NVIDIA driver. Proceed by typing `y` and `Enter`. Your VM will reboot.*


## Build Darknet

The build instructions are similar to the main repo's:

```
git clone https://github.com/ocervello/darknet-rtmp
cd darknet-rtmp
export GPU=1
make
```

## Setup
This fork adds a few helpful scripts to help you train / test / demo easily (designed for custom object detections):

* `train.sh` - Helper script to train Yolo
* `test.sh` - Test model against dataset
* `map.sh` - Get algorithm accuracy info (mAP)
* `demo.sh` - Run a live demo
* `save.sh` - Save a particular weight to `archive/` folder
* `optimize.sh` - Optimize your config (automation of AlexeyAB's README advice)

## Train
To train the algorith, run:
`train.sh`


## Run

### RTMP streaming

**RTMP streaming** enables you to stream your video / display from a client like OBS and read the output stream in another client like VLC.

To run `darknet` with RTMP streaming enabled (in and out), run:

```
./darknet detector demo cfg/coco.data cfg/yolov3.cfg yolov3.weights \
  -dont_show \
  -rtmp_fps <RTMP_FPS> \
  -rtmp_bps <RTMP_BPS> \
  -rtmp_port <RTMP_PORT> \
  -ext_output
  <RTMP_STREAM_URL>
```

where:
  * `RTMP_FPS` is the input stream FPS (video).
  * `RTMP_BPS` is the input stream BPS (audio).
  * `RTMP_STREAM_URL` is the input stream RTMP URL (e.g: `rtmp://localhost:1935/live/test`).
  * `RTMP_PORT` is the output RTMP port for streaming results. Default: 1935.

#### Demo
Follow the steps below to set up a demo environment:

1. Setup an RTMP server using `nginx` and the [nginx-rtmp-module](https://github.com/arut/nginx-rtmp-module).

2. Run YOLO with RTMP streaming enabled:
  ```
  ./darknet detector demo cfg/coco.data cfg/yolov3.cfg yolov3.weights -dont_show -rtmp_fps 30 -rtmp_bps 200000 -rtmp_port 1935 rtmp://localhost:1935/live/test
  ```

3. Download [OBS](https://obsproject.com) and setup a streaming source with the following settings:
    * Output resolution : `852x480`
    * FPS: `30`
    * URL: `rtmp://<RTMP_SERVER_IP>:<RTMP_PORT>/live/test`

4. Download [VLC](https://www.videolan.org/vlc/index.html), click on `File` > `Open Network Stream`, chose `RTMP` and enter the RTMP server URL: `rtmp://<RTMP_SERVER_IP>:<RTMP_PORT>/play`.

5. **Watch your stream !** Detected objects will be shown in bounding boxes with labels attached.

### MJPEG streaming

MJPEG streaming enables to stream JPEG images with bounding boxes in the browser.

To run `darknet` with MJPEG streaming enabled (in and out), run:

```
./darknet detector demo cfg/coco.data cfg/yolov3.cfg yolov3.weights \
  -dont_show \
  -json_port <JSON_PORT> \
  -ext_output \
  <RTMP_STREAM_URL | VIDEO_FILE | IMAGE_FILE>
```

where:
  * `JSON_PORT` is the output HTTP port for streaming JSON results.

### JSON streaming

JSON streaming enables bounding boxes coordinates to be accessible over HTTP.

To run `darknet` with JSON streaming enabled, run:

```
./darknet detector demo cfg/coco.data cfg/yolov3.cfg yolov3.weights \
  -dont_show \
  -json_port <JSON_PORT> \
  -ext_output \
  <RTMP_STREAM_URL | VIDEO_FILE | IMAGE_FILE>
```

where:
  * `JSON_PORT` is the output HTTP port for streaming JSON results.
