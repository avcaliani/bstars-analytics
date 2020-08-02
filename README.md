<img src=".docs/brawlstars.jpg" width="128px" align="right"/>

# BStars Analytics
By Anthony Vilarim Caliani

![#](https://img.shields.io/badge/licence-MIT-lightseagreen.svg)

Brawl Stars Analytics project is a simple ETL Pipeline that uses the data from [Brawl Stars Developer API](https://developer.brawlstars.com/).<br>
I'm a [Supercell](https://supercell.com/en/) fan and then I decided to develop this small project using [Brawl Stars](https://supercell.com/en/games/brawlstars/) thematic, of course respecting Supercell's [Fan Content Policy](http://www.supercell.com/fan-content-policy). By the way, the content of this repository is not affiliated with, endorsed, sponsored, or specifically approved by Supercell and they are not responsible for it.<br>


## Diagram
![diagram](.docs/diagram.png)


## Quick Start

Let's prepare our local environment...
```bash
# First, build docker image...
docker-compose build
# Then, start docker container...
docker-compose up -d
# When you finish, shutdown the container...
docker-compose down
```

### Executing Jobs Locally
App Collector
```bash
docker-compose exec bstars /app/app-collector/run.sh
```
App Ingestor
```bash
docker-compose exec bstars /app/app-ingestor/run.sh
```
App Processor
```bash
docker-compose exec bstars /app/app-processor/run.sh
```


## GCloud
Let's prepare the GCLoud environment...

### First Deploy

Creating Buckets
```bash
./devops/storage.sh --create bstars-repo
./devops/storage.sh --create bstars-logs
./devops/storage.sh --create bstars-transient
./devops/storage.sh --create bstars-raw
```

Deploying Apps
```bash
./devops/app-deploy.sh app-collector
# TODO: app-ingestor
# TODO: app-processor
```

Creating Compute Instance
```bash
./devops/ip-address.sh --create  # Region: us-central1 && Save the IP Address
./devops/compute.sh --create 127.0.0.1  # Generated IP Address
```

Creating Cloud Pub/Sub Topic, Cloud Function, and Cloud Scheduler services
```bash
./devops/pubsub.sh --create
./devops/function.sh --create start-instance
./devops/schedule.sh --create
```


## Screenshots
![screenshot](.docs/screenshot.png)


## Related Links
- [Supercell: Official Website](https://supercell.com/en/)
- [Brawl Stars: Developer API](https://developer.brawlstars.com/)
- [Brawl Stars: Media](https://supercell.com/en/for-media/)

