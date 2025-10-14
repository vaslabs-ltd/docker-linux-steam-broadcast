# Steam-Stream

## Description
Steam-Stream is a Dockerized application that streams video files to Steam using FFmpeg.

## Usage

Build and start the service using Docker Compose:

```bash
docker compose up --build
```

- Place your video files in the `videos` directory.
- Place your playlist file as `playlist.txt` in the project root.
- Set the `STEAM_KEY` environment variable in a `.env` file.