# 执行一些自定义的action脚本

## Publish Nextcloud to DockerHub
自动打包Nextcloud自定义镜像至DockerHub, 手动触发时的title来设置image的tag

## Publish acme.sh docker to DockerHub

封装acme.sh，并将镜像推送至DockerHub

### 镜像使用方法

```bash
docker run -d \
-e EMAIL=abc@example.com \
-e DOMAINS=a.example.com,b.example.com,*.c.example.com \
-e API=DNSPOD;dpid,dpkey \
-v /path/to/ssl:/ssl
halfcoke/acme.sh
```

