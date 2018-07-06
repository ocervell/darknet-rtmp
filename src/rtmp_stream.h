#pragma once
#ifndef RTMP_STREAM_H
#define RTMP_STREAM_H

#ifdef __cplusplus
extern "C" {
#endif
#include "image.h"

void init_rtmp_server(double width, double height, int fps, int bitrate, char *codec_profile, char *server);
void send_rtmp_frame(IplImage* ipl);

#ifdef __cplusplus
}
#endif

#endif // RTMP_STREAM_H