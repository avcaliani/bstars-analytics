<img src=".docs/brawlstars.jpg" width="128px" align="right"/>

# BS Analytics
By Anthony Vilarim Caliani

![#](https://img.shields.io/badge/licence-MIT-lightseagreen.svg)

Brawl Stars Analytics project is a simple ETL Pipeline that uses the data from [Brawl Stars Developer API](https://developer.brawlstars.com/).<br>
I'm a [Supercell](https://supercell.com/en/) fan and then I decided to develop this small project using [Brawl Stars](https://supercell.com/en/games/brawlstars/) thematic, of course respecting Supercell's [Fan Content Policy](http://www.supercell.com/fan-content-policy). By the way, the content of this repository is not affiliated with, endorsed, sponsored, or specifically approved by Supercell and they are not responsible for it.<br>


## Diagram
![diagram](.docs/diagram.png)


## Quick Start
```bash
# 404 - Quick Start not found!
docker-compose build
docker-compose up -d
docker-compose exec bs-analytics /app/app-collector/run.sh
docker-compose exec bs-analytics /app/app-ingestor/run.sh
docker-compose exec bs-analytics /app/app-processor/run.sh
```

## Screenshot
![screenshot](.docs/screenshot.png)


## Related Links
- [Supercell: Official Website](https://supercell.com/en/)
- [Brawl Stars: Developer API](https://developer.brawlstars.com/)
- [Brawl Stars: Media](https://supercell.com/en/for-media/)

