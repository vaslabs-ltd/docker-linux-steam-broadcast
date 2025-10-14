# Steam-Stream

## Description
Steam-Stream is a Dockerized application that streams video files to Steam using FFmpeg.

## Usage:
Build the Docker image:

```bash
docker build -t steam-stream .
```

Run the Docker container, mounting your video directory and playlist file:

```bash
docker run --it --rm --env-file .env -v /path/to/videos:/videos -v /path/to/playlist:/playlist.txt steam-stream
```
- `playlist.txt` should contain paths to video files relative to the `/videos` directory, one per line. Example:
```
video1.mp4
subdir/video2.mkv
```
- The application converts these videos to FLV format and streams them to Steam in a continuous loop.
- Make sure to set the `STEAM_KEY` environment variable in a `.env` file (or pass with `-e` flag when running the container).