# 简单编写的，慢慢完善。可用，好像存在问题。

#! /bin/bash

# 安装
apt update
apt install aria2

# 配置文件
cd ~
mkdir .aria2
cd .aria2
touch aria2.conf aria2.session aria2.log

cat > ~/.aria2/aria2.conf<<-EOF
## '#'开头为注释内容, 选项都有相应的注释说明, 根据需要修改 ##
## 被注释的选项填写的是默认值, 建议在需要修改时再取消注释 ##
## 只写了常用配置项，高级项查看Ariag ##

## 默认情况下，传统的路径aria2检查是否 $HOME/.aria2/aria2.conf存在，否则它解析$XDG_CONFIG_HOME/aria2/aria2.conf为它的配置文件。您可以使用指定配置文## 件的路径--conf-path 选择。如果你不想使用配置文件，使用 --no-conf选项。

## 基本设置

# 文件的保存路径(可使用绝对路径或相对路径), 默认: 当前启动位置
dir=~/Downloads
# 最大同时下载任务数, 运行时可修改, 默认:5
max-concurrent-downloads=1
# 日志文件
log=~/.aria2/aria2.log
# 检查完整性
check-integrity=true
# 断点续传
continue=true

## HTTP/FTP/SFTP设置

# 代理服务器
#all-proxy=127.0.0.1:8087
# 代理服务器用户名
#all-proxy-user=
# 代理服务器密码
#all-proxy-passwd=

## 下载连接相关

# 同一服务器连接数, 添加时可指定, 默认:1
max-connection-per-server=5

# 禁用IPv6, 默认:false
disable-ipv6=false

## 进度保存相关 ##

# 从会话文件中读取下载任务
input-file=~/.aria2/aria2.session
# 在Aria2退出时保存`错误/未完成`的下载任务到会话文件
save-session=~/.aria2/aria2.session
# 定时保存会话, 0为退出时才保存, 需1.16.1以上版本, 默认:0
#save-session-interval=60

## RPC相关设置 ##

# 启用RPC, 默认:false
enable-rpc=true
# 允许所有来源, 默认:false
rpc-allow-origin-all=true
# 允许非外部访问, 默认:false
rpc-listen-all=true
# 事件轮询方式, 取值:[epoll, kqueue, port, poll, select], 不同系统默认值不同
#event-poll=select
# RPC监听端口, 端口被占用时可以修改, 默认:6800
#rpc-listen-port=6800
# 设置的RPC授权令牌, v1.18.4新增功能, 取代 --rpc-user 和 --rpc-passwd 选项
#rpc-secret=<TOKEN>

## BT/PT下载相关 ##

# BT监听端口, 当端口被屏蔽时使用, 默认:6881-6999
#listen-port=51413
# 打开DHT功能, PT需要禁用, 默认:true
enable-dht=true
# 打开IPv6 DHT功能, PT需要禁用
enable-dht6=true
# DHT网络监听端口, 默认:6881-6999
#dht-listen-port=6881-6999
# 本地节点查找, PT需要禁用, 默认:false
bt-enable-lpd=true
# 当种子的分享率达到这个数时, 自动停止做种, 0为一直做种, 默认:1.0
seed-ratio=0.1
# 最小做种时间，分。为0时表示不做种。
seed-time=0
# BT校验相关, 默认:true
#bt-hash-check-seed=true
# 继续之前的BT任务时, 无需再次校验, 默认:false
bt-seed-unverified=true
# 全局最大上传速度
max-overall-upload-limit=1K
# 最大上传速度
max-upload-limit=1K
EOF

# 后台启动
aria2c -D

# Web管理
apt install nginx unzip
wget https://github.com/mayswind/AriaNg/releases/download/0.2.0/aria-ng-0.2.0.zip
unzip aria-ng-*.zip -d ./rly61
mv ./rly61/* /var/www/html/
service nginx restart
rm -rf rly61 aria-ng-*.zip
