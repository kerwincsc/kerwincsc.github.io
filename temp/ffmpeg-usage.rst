FFmpeg 使用介绍
======================================================================

嵌入字幕到视频文件中
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

- 嵌入 SRT 字幕到视频文件

  ::
     # subtitle.srt 为字幕文件
     ffmpeg -i video.avi -vf subtitles=subtitle.srt out.avi

- 嵌入 ASS 字幕到视频文件

  ::

     ffmpeg -i video.avi -vf "ass=subtitle.ass" out.avi

字幕文件转换
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

- SRT -> ASS

  ::

     ffmpeg -i subtitle.srt subtitle.ass

- ASS -> SRT

  ::

     fmpeg -i subtitle.ass subtitle.srt
