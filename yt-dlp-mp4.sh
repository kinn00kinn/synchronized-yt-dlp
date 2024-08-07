#!/bin/bash

# list-mp3.txtをおいているフォルダ
cd /data/data/com.termux/files/home/storage/downloads/synchronized-yt-dlp || exit 1

# 読み込むファイル（改行区切りでurlが貼ってある）
urlfile="list-mp4.txt"

# ファイルの個数確認（コメント行を除外）
filenum=$(grep -v '^#' "$urlfile" | wc -l)
filenum=$((filenum))
echo "filenumber: $filenum"
echo

# コメント行を除外してファイルにURLを代入
mapfile -t file < <(grep -v '^#' "$urlfile" | sed -n "${1},\$p")

# 並列処理
for ((i=0; i<${#file[@]}; i++)); do
  url=${file[i]}
  nohup yt-dlp "$url" \
    > "yt-dlp_${i}.log" 2>&1 &

  # プログレス表示
  echo "Processing file $((i+1))/$filenum"
done

# 完了メッセージ
echo "All downloads started."

