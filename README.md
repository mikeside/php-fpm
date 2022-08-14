# Mike PHP-FPM Image


## 介绍
php-fpm镜像，支持多平台架构，内置了丰富的php常用扩展composer2等 ，免安装开箱即用等

## 定制软件列表
``
更换apt镜像源
``
``
vim
``
``
wget
``
``
git
``
``
zip
``
``
composer
``
``
extend-redis
``
``
extend-amqp
``
``
extend-swoole
``

## 安装教程
- 根据自己需求可安装php不同版本镜像
- 拉取慢，配置一下镜像代理

```
# 中科大
https://docker.mirrors.ustc.edu.cn
# 腾讯云
https://mirror.ccs.tencentyun.com
```

```
docker pull mikeside/php-fpm
docker pull mikeside/php-fpm:7.4-1.0
```

```
docker run -d -p 9000:9000 --name php-fpm mikeside/php-fpm
```


## 使用说明
- php配置文件路径

  ```
  /usr/local/etc/php/php.ini
  /usr/local/etc/php-fpm.conf
  ```
  





