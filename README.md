# Docker-redis

### 介绍
##### 此为开发测试用的单机单节点Redis，可利用.env配置主或从

#### 不可将此版本直接部署至生产环境

本镜像包含：
* redis

#### 以下流程基于Centos7-minimal的系统进行部署，其他系统请参考。

### 安装Docker CE

*  #### 卸载旧版本

旧版本的 Docker 称为 docker 或者 docker-engine，使用以下命令卸载旧版本：

```shell script
$ sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
```

* #### 使用 yum 源 安装 依赖

执行以下命令安装依赖包：

```shell script
$ sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
```

* #### 添加yum 软件源

鉴于国内网络问题，强烈建议使用国内源，下面先介绍国内源的使用。

添加国内源

```shell script
$ sudo yum-config-manager \
    --add-repo \
    https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```
    
添加官方源

```shell script
$ sudo yum-config-manager \
    --add-repo \
     https://download.docker.com/linux/centos/docker-ce.repo 
```

* #### 安装 Docker CE

```shell script
$ sudo yum install docker-ce docker-ce-cli containerd.io
```

* #### 启动 Docker CE

```shell script
$ systemctl start docker      #启动docker
$ systemctl enable docker     #激活开机启动
```
* #### 添加国内镜像加速器

国内从 Docker Hub 拉取镜像有时会遇到困难，此时可以配置镜像加速器。国内很多云服务商都提供了国内加速器服务，例如：

+ Azure 中国镜像 https://dockerhub.azk8s.cn
+ 阿里云加速器(需登录账号获取)
+ 七牛云加速器 https://reg-mirror.qiniu.com

由于镜像服务可能出现宕机，建议同时配置多个镜像。

国内各大云服务商均提供了 Docker 镜像加速服务，建议根据运行 Docker 的云平台选择对应的镜像加速服务，具体请参考官方文档。

* Centos7添加国内源

对于使用 `systemd` 的系统，请在 `/etc/docker/daemon.json` 中写入如下内容（如果文件不存在请新建该文件）

```json
{
  "registry-mirrors": [
    "https://dockerhub.azk8s.cn",
    "https://reg-mirror.qiniu.com"
  ]
}
```

注意，一定要保证该文件符合 json 规范，否则 Docker 将不能启动。

之后重新启动服务。

```shell script
$ sudo systemctl daemon-reload
$ sudo systemctl restart docker
```
查看版本号

```shell script
$ docker version
```

### 安装Docker Compose

* 运行以下命令下载正确的Docker Compose版本:

```shell script
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

如果要安装不同的版本，替换 `1.24.1` 为你想使用的版本。

* 添加执行权限:

```shell script
sudo chmod +x /usr/local/bin/docker-compose
```

* 软连接到全局执行
```shell script
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

* 检查安装:

```shell script
$ docker-compose --version
docker-compose version 1.24.1, build 1110ad01
```
### 部署redis
* 建议创建uid为1000的用户
* git clone 此项目
* 将此项目的own改为1000的用户

在项目docker-compose.yml文件所在目录，执行docker-compose
* 根据.env.exsample生成.env
```shell script
$ cp .env.example .env
```

* 修改内容，添加版本号及AnnounceIP和Port
```shell script
$ vi .env
```

```shell script
#Redis version
REDIS_VERSION=5.0.5
#Redis announce ip and port
ANNOUNCE_IP=
ANNOUNCE_PORT=                                  
```

* 启动docker-redis
```shell script
$ docker-compose up -d
```

* 检查docker-redis启动情况
```shell script
$ docker-compose ps
Name               Command               State            Ports         
------------------------------------------------------------------------
redis   /bin/bash /usr/src/sh/redis.sh   Up      0.0.0.0:10001->6379/tcp
```

#### 参考网站
* Docker CE Centos安装官方文档： https://docs.docker.com/install/linux/docker-ce/centos/
* Docker Compose安装官方文档： https://docs.docker.com/compose/install/
* Docker 国内镜像源： https://yeasy.gitbooks.io/docker_practice/content/install/mirror.html 