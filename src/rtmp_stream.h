#ifndef RTMP_STREAM_H
#define RTMP_STREAM_H
#include "darknet.h"

#ifdef __cplusplus
extern "C" {
#endif
#include "image.h"

void init_rtmp_server(double width, double height, int fps, int bitrate, char *codec_profile, char *server);

#ifdef OPENCV
void send_rtmp_frame(mat_cv* mat);

#endif  // OPENCV

#ifdef __cplusplus
}
#endif

#endif // RTMP_STREAM_H
