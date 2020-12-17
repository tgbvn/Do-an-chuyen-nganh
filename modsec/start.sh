service apache2 start
filebeat -e -c filebeat.yml -d "publish"