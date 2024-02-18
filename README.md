# はじめに
synchronised-yt-dlpとはyt-dlpをベースとしたyoutubeをダウンロード出来るプログラムです．shellscriptを利用して並列にダウンロードするよう設計されているので，高速にダウンロードできます．

# インストール方法
## 前提プログラムのインストール
ここではtermuxを前提としたインストール方法を記述しているので，各々の環境に合わせてインストール方法を変えてください．

```bash
pkg update && pkg upgrade
pkg install git awk python python-pip
pip install yt-dlp
termux-setup-storage
```

## このプログラムのインストール方法
```
git clone https://github.com/kinn00kinn/synchronized-yt-dlp.git
cd synchronized-yt-dlp
chmod +x *.sh
```

# 使い方
このプログラムはダウンロードする場所と，プログラムを実行する場所を別々にしています．なのでプログラムを実行する前に保存場所を作ってください．

1. 保存場所を作る
```bash
cd storage/downloads
mkdir yt-dlp
cd yt-dlp
echo "#mp3" > list_mp3.txt
echo "#mp4" > list_mp4.txt
```

2. list_mp3.txt or list_mp4.txtに改行区切りでダウンロードしたいurlを貼る
list_mp3.txtの中身の例
```txt
#mp3
#3行目から貼り付けてね
https://youtu.be/EtqP2xVE4iY 
```

3. synchronized-yt-dlpのフォルダに戻って実行
```bash
cd ~/synchronized-yt-dlp
./yt-dlp-mp3.sh
```






