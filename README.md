# Live Recorder Image Builder

This repository builds the Docker image for
[`ihmily/DouyinLiveRecorder`](https://github.com/ihmily/DouyinLiveRecorder)
on a weekly schedule and pushes it to Docker Hub.

The image adds Unraid-friendly runtime user handling. By default the recorder
runs as `PUID=99` and `PGID=100`, matching Unraid's `nobody:users` ownership.
You can override both values in the Unraid container template.

## Docker Hub

Image:

```text
chihotam/live-recorder
```

Required GitHub Actions secret:

```text
DOCKERHUB_TOKEN
```

The Docker Hub access token only needs `Read & Write` permission.

## Unraid

Recommended environment variables:

```text
PUID=99
PGID=100
UMASK=000
TZ=Asia/Shanghai
```

Recommended volume mappings:

```text
/mnt/user/appdata/live-recorder/config -> /app/config
/mnt/user/appdata/live-recorder/logs -> /app/logs
/mnt/user/appdata/live-recorder/backup_config -> /app/backup_config
/mnt/user/recordings/live-recorder -> /app/downloads
```

The container starts as root only long enough to fix ownership on the mounted
directories, then runs `python main.py` as `PUID:PGID`.

`UMASK=000` makes new recordings writable from SMB clients. If you prefer a
slightly tighter setup, use `UMASK=002` and make sure your SMB user has write
access through the `users` group.
