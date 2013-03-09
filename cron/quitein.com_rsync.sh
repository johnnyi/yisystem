/usr/bin/rsync -vzrtopg --exclude='.svn/'  --exclude='upload' --exclude='fimages' --delete --progress 10.0.0.173::data0.quitein /data/httpd/sync.quitein.com/channel/project.quitein/sources --password-file=/etc/rsyncd.pwd
/usr/bin/rsync -vzrtopg --exclude='.svn/'  --delete --progress 10.0.0.173::data0.pic /data/httpd/sync.quitein.com/channel/project.pic/sources --password-file=/etc/rsyncd.pwd
/usr/bin/rsync -vzrtopg --exclude='.svn/'  --delete --progress 10.0.0.173::data0.images /data/httpd/sync.quitein.com/channel/project.images/sources --password-file=/etc/rsyncd.pwd
/usr/bin/rsync -vzrtopg --exclude='.svn/'  --delete --progress 10.0.0.173::data0.interface /data/httpd/sync.quitein.com/channel/project.interface/sources --password-file=/etc/rsyncd.pwd
/usr/bin/rsync -vzrtopg --exclude='.svn/'  --delete --progress 10.0.0.173::data0.game /data/httpd/sync.quitein.com/channel/project.game/sources --password-file=/etc/rsyncd.pwd
