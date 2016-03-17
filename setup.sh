#!/bin/sh

# TODO: discover latest available Tomcat version automatically
TOMCAT="8.0.30"
MIRROR="http://ftp.piotrkosoft.net/pub/mirrors/ftp.apache.org"
TCDIR="apache-tomcat-$TOMCAT"


/opt/farm/scripts/setup/role.sh sf-java8

mkdir -p /srv/sites
DIR="`pwd`"

if [ ! -d /opt/$TCDIR ]; then
	cd /opt
	wget $MIRROR/tomcat/tomcat-8/v$TOMCAT/bin/$TCDIR.tar.gz
	tar xzf $TCDIR.tar.gz
	rm -f $TCDIR.tar.gz
	cd "$DIR"
fi

if [ ! -d /srv/sites/tomcat ]; then
	cd $TCDIR
	mkdir /srv/sites/tomcat
	cp -at /srv/sites/tomcat conf logs temp webapps work
	cd "$DIR"
fi

ln -sf /opt/$TCDIR/bin /srv/sites/tomcat
ln -sf /opt/$TCDIR/lib /srv/sites/tomcat

if ! grep -q CATALINA_HOME /etc/environment; then
	echo 'CATALINA_HOME="/srv/sites/tomcat"' >>/etc/environment
fi
