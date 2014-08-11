#!/usr/bin/env bash
set -x
/var/www/html/phabricator-server/libphutil/scripts/build_xhpast.sh
BACKUP_DIR=${1}

if [ -z ${1} ];then
	echo "please input the BACKUP_DIR"
	exit 1
fi


# 在共享目录创建单独的目录 存储此次备份的所有数据
mkdir -p /vagrant/backup/${BACKUP_DIR}

# 备份数据库
cd /var/www/html/phabricator-server/phabricator
./bin/storage dump | gzip > /vagrant/backup/${BACKUP_DIR}/backup.sql.gz

# 备份配置文件
cd /var/www/html/phabricator-server/phabricator/conf/
cp -rf local/ /vagrant/backup/${BACKUP_DIR}/
if [ -d "custom" ];then
	cp -rf custom/ /vagrant/backup/${BACKUP_DIR}/
fi 

