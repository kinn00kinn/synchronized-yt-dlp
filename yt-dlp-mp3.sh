#!/bin/sh

# list-mp3.txtをおいているフォルダ
#cd /data/data/com.termux/files/home/storage/downloads/synchronized-yt-dlp || exit 1

# 読み込むファイル（改行区切りでurlが貼ってある）
urlfile="list-mp3.txt"
outdir = "data"

# ファイルの個数確認（コメント行を除外）
filenum=$(grep -v '^#' "$urlfile" | wc -l)
echo "filenumber: $filenum"
echo

# コメント行を除外してURLを順に処理
i=0
grep -v '^#' "$urlfile" | while IFS= read -r url; do
  # 空行を無視
  [ -z "$url" ] && continue

  # URLを処理
  nohup yt-dlp -x -f "bestaudio" --audio-format mp3 --audio-quality 0 "$url" -P "$outdir" &

  # プログレス表示
  i=$((i+1))
  echo "Processing file $i/$filenum"
done

# 完了メッセージ
echo "All downloads started."
