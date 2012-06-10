#!/bin/bash
source ../../../virtualenv/Linux/x86_64/python2.7/bin/activate

CORES=$(cat /proc/cpuinfo  | grep processor | wc -l)
WORKERS=$(echo "$CORES*2+1" | bc)
CORESM1=$(echo "$CORES-1" | bc)
sudo /etc/init.d/nginx start
sudo /etc/init.d/apache2 start
sudo /etc/init.d/lighttpd start
nohup ./tornado_1worker &
nohup ./twisted_1worker  &
nohup ../../../bin/server_daemon start

nohup ./gevent_server_test -b 0.0.0.0:8090 -w 1 &
nohup ./gevent_server_test -b 0.0.0.0:8091 -w $CORES &
nohup ./gevent_server_test -b 0.0.0.0:8092 -w $WORKERS &
nohup ./gevent_server_test -b 0.0.0.0:8093 -w 1 --pywsgi &
nohup ./gevent_server_test -b 0.0.0.0:8094 -w $CORES --pywsgi &
nohup ./gevent_server_test -b 0.0.0.0:8095 -w $WORKERS --pywsgi &
nohup ./gevent_server_test -b 0.0.0.0:8096 -w $CORESM1 &
nohup ./gevent_server_test -b 0.0.0.0:8097 -w $CORESM1 --pywsgi &


nohup ./tornado_server_test -b 0.0.0.0:8880 -w 1 &
nohup ./tornado_server_test -b 0.0.0.0:8881 -w $WORKERS &   
nohup ./tornado_server_test -b 0.0.0.0:8882 -w $CORES &
nohup ./tornado_server_test -b 0.0.0.0:8883 -w $CORESM1 &

nohup gunicorn -D -b 0.0.0.0:8082 -w 1 -k gevent gunicorn_gochat_test:app	 
nohup gunicorn -D -b 0.0.0.0:8083 -w $WORKERS -k gevent gunicorn_gochat_test:app	 
nohup gunicorn -D -b 0.0.0.0:8084 -w $CORES -k gevent gunicorn_gochat_test:app	 
nohup gunicorn -D -b 0.0.0.0:8085 -w $CORESM1 -k gevent gunicorn_gochat_test:app	 

nohup gunicorn -D -b 0.0.0.0:8000 -w $WORKERS -k sync gunicorn_test:app
nohup gunicorn -D -b 0.0.0.0:8001 -w $WORKERS -k eventlet gunicorn_test:app
nohup gunicorn -D -b 0.0.0.0:8002 -w $WORKERS -k gevent gunicorn_test:app
nohup gunicorn -D -b 0.0.0.0:8003 -w $WORKERS -k tornado gunicorn_test:app

nohup gunicorn -D -b 0.0.0.0:8004 -w $CORES -k sync gunicorn_test:app
nohup gunicorn -D -b 0.0.0.0:8005 -w $CORES -k eventlet gunicorn_test:app
nohup gunicorn -D -b 0.0.0.0:8006 -w $CORES -k gevent gunicorn_test:app
nohup gunicorn -D -b 0.0.0.0:8007 -w $CORES -k tornado gunicorn_test:app

nohup gunicorn -D -b 0.0.0.0:8008 -w $CORESM1 -k sync gunicorn_test:app
nohup gunicorn -D -b 0.0.0.0:8009 -w $CORESM1 -k eventlet gunicorn_test:app
nohup gunicorn -D -b 0.0.0.0:8010 -w $CORESM1 -k gevent gunicorn_test:app
nohup gunicorn -D -b 0.0.0.0:8011 -w $CORESM1 -k tornado gunicorn_test:app

nohup gunicorn -D -b 0.0.0.0:8100 -w 1 -k sync gunicorn_test:app
nohup gunicorn -D -b 0.0.0.0:8101 -w 1 -k eventlet gunicorn_test:app
nohup gunicorn -D -b 0.0.0.0:8102 -w 1 -k gevent gunicorn_test:app
nohup gunicorn -D -b 0.0.0.0:8103 -w 1 -k tornado gunicorn_test:app

