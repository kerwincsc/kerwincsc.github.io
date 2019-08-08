FFmpeg 使用介绍
======================================================================

视频分割与合并
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

- 分割视频

  ::

     ffmpeg -ss 00:00:00 -t 00:00:30 -i teste.mp4 -vcodec copy -acodec copy output.mp4

  - -ss 指定从什么时间开始
  - -t 指定需要截取多长时间
  - -i 指定输入文件

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


     ffmpeg -i input.mp4 -filter:v setpts=0.5*PTS output.mp4

//音频变速
ffmpeg -i input.mp3 -filter:a atempo=2.0 output.mp3

//音视频同时变速，但是音视频为互倒关系
ffmpeg -i input.mp4 -filter_complex "[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]" -map "[v]" -map "[a]" output.mp4


// 视频添加水印
ffmpeg -i input.mp4 -i logo.jpg -filter_complex [0:v][1:v]overlay=main_w-overlay_w-10:main_h-overlay_h-10[out] -map [out] -map 0:a -codec:a copy output.mp4
// main_w-overlay_w-10 视频的宽度-水印的宽度-水印边距；~



// 截取视频局部
ffmpeg -i in.mp4 -filter:v "crop=out_w:out_h:x:y" out.mp4
// 截取部分视频，从[80,60]的位置开始，截取宽200，高100的视频
ffmpeg -i in.mp4 -filter:v "crop=80:60:200:100" -c:a copy out.mp4
// 截取右下角的四分之一
ffmpeg -i in.mp4 -filter:v "crop=in_w/2:in_h/2:in_w/2:in_h/2" -c:a copy out.mp4
// 截去底部40像素高度
ffmpeg -i in.mp4 -filter:v "crop=in_w:in_h-40" -c:a copy out.mp4

参数说明：
-vcodec xvid 使用xvid压缩
-s 320x240 指定分辨率
-r fps 设置帧频 缺省25
-b <比特率> 指定压缩比特
-acodec aac 设定声音编码
-ac <数值> 设定声道数，1就是单声道，2就是立体声
-ar <采样率> 设定声音采样率，PSP只认24000
-ab <比特率> 设定声音比特率
-vol <百分比> 设定音量
-y（覆盖输出文件
-t duration 设置纪录时间 hh:mm:ss[.xxx]格式的记录时间也支持
-ss position 搜索到指定的时间 [-]hh:mm:ss[.xxx]的格式也支持
-title string 设置标题
-author string 设置作者
-copyright string 设置版权
-hq 激活高质量设置
-aspect aspect 设置横纵比 4:3 16:9 或 1.3333 1.7777
-croptop size 设置顶部切除带大小 像素单位
-cropbottom size -cropleft size -cropright size
-padtop size 设置顶部补齐的大小 像素单位
-padbottom size -padleft size -padright size -padcolor color 设置补齐条颜色(hex,6个16进制的数，红:绿:兰排列，比如 000000代表黑色)
-bt tolerance 设置视频码率容忍度kbit/s
-maxrate bitrate设置最大视频码率容忍度
-minrate bitreate 设置最小视频码率容忍度
-bufsize size 设置码率控制缓冲区大小
-vcodec codec 强制使用codec编解码方式。 如果用copy表示原始编解码数据必须被拷贝。
-sameq 使用同样视频质量作为源（VBR）
-pass n 选择处理遍数（1或者2）。两遍编码非常有用。第一遍生成统计信息，第二遍生成精确的请求的码率
-passlogfile file 选择两遍的纪录文件名为file
-map file:stream 设置输入流映射
-debug 打印特定调试信息
