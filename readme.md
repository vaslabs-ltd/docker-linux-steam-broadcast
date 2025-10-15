# Dockerized Steam Broadcast

## Description

A Dockerized application that broadcasts video files to Steam using FFmpeg. Meant to be used in DIY situations where you'd want to broadcast your pre-recorded videos from a Linux machine/server!

## Usage

- Place your video files in the `videos` directory.
- Place your playlist file as `playlist.txt` in the project root. 
- Set the `STEAM_KEY` environment variable in a `.env` file.

Build and start the service using Docker Compose:

```bash
docker compose up --build
```


## Configuration
- To get your Steam key, follow the instructions at [Steamworks Documentation](https://partner.steamgames.com/doc/store/broadcast/setting_up).
- The `playlist.txt` should contain paths to video files relative to the `/videos` directory, one per line. Example:
```
video1.mp4
subdir/video2.mkv
```

## Requirements
- All video files must have the same frame rate.

## Credits

The containarised script is packaged using the base image of [linuxserver/docker-ffmpeg](https://github.com/linuxserver/docker-ffmpeg/) which is licensed under [GNU General Public License v3.0](https://github.com/linuxserver/docker-ffmpeg/blob/master/LICENSE)
