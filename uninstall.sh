#!/bin/sh

if grep -q CATALINA_HOME /etc/environment; then
	sed -i -e "/CATALINA_HOME/d" /etc/environment
fi
