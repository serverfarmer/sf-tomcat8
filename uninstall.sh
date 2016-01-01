#!/bin/sh

if grep -q CATALINA_HOME /etc/crontab; then
	sed -i -e "/CATALINA_HOME/d" /etc/crontab
fi
