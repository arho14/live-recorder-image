# Live Recorder Image Builder

This repository builds the Docker image for
[`ihmily/DouyinLiveRecorder`](https://github.com/ihmily/DouyinLiveRecorder)
on a weekly schedule and pushes it to Docker Hub.

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
