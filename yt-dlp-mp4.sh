#!/bin/bash
# list-mp3.txtをおいているフォルダ
#cd /data/data/com.termux/files/home/storage/downloads/synchronized-yt-dlp || exit 1

# 読み込むファイル（改行区切りでurlが貼ってある）
urlfile="list-mp4.txt"
outdir="data"

# ファイルの個数確認（コメント行を除外）
filenum=$(grep -v '^#' "$urlfile" | wc -l)
filenum=$((filenum))
echo "filenumber: $filenum"
echo

# コメント行を除外してファイルにURLを代入
file=()
while IFS= read -r line; do
  # 空行やコメント行を除外
  if [[ -n "$line" && ! "$line" =~ ^# ]]; then
    file+=("$line")
  fi
done < "$urlfile"

# 並列処理
for ((i=0; i<${#file[@]}; i++)); do
  url=${file[i]}
    nohup yt-dlp "$url" -f mp4 -P $outdir &

  # プログレス表示
  echo "Processing file $((i+1))/$filenum"
done

# 完了メッセージ
echo "All downloads started."

#!/bin/sh

# list-mp3.txtをおいているフォルダ
cd /data/data/com.termux/files/home/storage/downloads/synchronized-yt-dlp || exit 1

# 読み込むファイル（改行区切りでurlが貼ってある）
urlfile="list-mp3.txt"

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
  nohup yt-dlp "$url" -f mp4 -P src &

  # プログレス表示
  i=$((i+1))
  echo "Processing file $i/$filenum"
done

# 完了メッセージ
echo "All downloads started."
