#!/bin/bash
source ../../../virtualenv/Linux/x86_64/python2.7/bin/activate
function kill_python
{
	for pid in $(ps -ef | grep "$1" | grep -v grep | awk '{print $2}');
	do
		kill -9 $pid
	done
}


sudo /etc/init.d/nginx stop
sudo /etc/init.d/apache2 stop
sudo /etc/init.d/lighttpd stop
pkill -9 gunicorn
../../../bin/server_daemon stop
kill_python "tornado"
kill_python "twisted"
kill_python "gevent"
