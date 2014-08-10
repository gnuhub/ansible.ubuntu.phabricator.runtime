#!/usr/bin/env bash
# 参数 $1 BACKUP_BUMBER
set -x
/var/www/html/phabricator-server/libphutil/scripts/build_xhpast.sh
# 恢复数据库
cd /vagrant/backup/${1}
gunzip -c backup.sql.gz | mysql
# 恢复配置文件
cd /vagrant/backup/${1}
cp -rf local/ /var/www/html/phabricator-server/phabricator/conf/