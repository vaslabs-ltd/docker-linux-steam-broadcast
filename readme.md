# Dockerized Steam Broadcast

## Description
A Dockerized application that streams video files to Steam using FFmpeg.

## Usage

Build and start the service using Docker Compose:

```bash
docker compose up --build
```

- Place your video files in the `videos` directory.
- Place your playlist file as `playlist.txt` in the project root. 
- Set the `STEAM_KEY` environment variable in a `.env` file.

## Configuration
- To get your Steam key, follow the instructions at [Steamworks Documentation](https://partner.steamgames.com/doc/store/broadcast/setting_up).
- The `playlist.txt` should contain paths to video files relative to the `/videos` directory, one per line. Example:
```
video1.mp4
subdir/video2.mkv
```

## Requirements
- All video files must have the same frame rate.
