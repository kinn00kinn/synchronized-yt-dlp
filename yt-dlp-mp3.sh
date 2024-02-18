#!/bin/bash

#list-mp3.txtをおいているフォルダ
cd /data/data/com.termux/files/home/storage/downloads/synchronized-yt-dlp

#読み込むファイル（改行区切りでurlが貼ってある）
urlfile="list-mp3.txt"

#魔法の変数
tmp2=1
tmp3=1
tmp4=2
tmp5=2

#ファイルの個数確認
filenum=`awk 'END{print NR-2}' $urlfile`
echo "filenumber:" $filenum
echo

#fileにurlを代入
for ((i=3; i<$filenum+3; i++)); do
  tmp1=`echo $i"p"`
  file[i]=`sed -n $tmp1 list-mp3.txt`
  echo $tmp2". "${file[i]}
  tmp2=$(($tmp2 + $tmp3))
done

#並列処理
for ((i=3; i<$filenum+3; i++)); do
  if test $i -eq $(($filenum+$tmp4)); then
          (nohup yt-dlp -x -f "bestaudio" --audio-format mp3 --audio-quality 0 ${file[i]}; echo "<= "$(($i-$tmp5))" => "done) &
  else
          (nohup yt-dlp -x -f "bestaudio" --audio-format mp3 --audio-quality 0 ${file[i]}; echo "<= "$(($i-$tmp5))" => "done) &
  fi

done
