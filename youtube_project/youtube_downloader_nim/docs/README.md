# Nim YouTube Downloader

A professional YouTube downloader written in Nim, featuring:

- 🎬 Single video downloads
- 📁 Playlist support  
- 📋 Bulk downloads from file
- 🎵 Multiple formats (MP4, MP3, M4A)
- 🎯 Quality options (144p to 4K)
- 🖥️ Cross-platform compatibility
- 🎨 Interactive CLI with colored output

## Installation

1. Install Nim on Arch Linux:
```bash
sudo pacman -S nim
````

2.  Install yt-dlp (required):

<!-- end list -->

```bash
sudo pacman -S yt-dlp
# or: pip install yt-dlp
```

3.  Build the project:

<!-- end list -->

```bash
make build
```

## Usage

### Interactive Mode

```bash
./bin/youtube_downloader
```

### Single Video Download

```bash
./bin/youtube_downloader "[https://youtube.com/watch?v=VIDEO_ID](https://youtube.com/watch?v=VIDEO_ID)"

# Download as MP3
./bin/youtube_downloader "URL" --format=audio --outputFormat=mp3 --quality=320k

# Download in 4K
./bin/youtube_downloader "URL" --quality=2160p
```

### Playlist Download

```bash
./bin/youtube_downloader "PLAYLIST_URL" --format=audio --outputFormat=mp3
```

### Bulk Download

```bash
./bin/youtube_downloader --filename=urls.txt --quality=720p
```

## Legal Notice

This tool is for educational purposes only. Respect YouTube's Terms of Service and copyright laws.
