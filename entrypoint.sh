#!/bin/sh

set -x

pkill httpd
pkill httpd
pkill httpd

rm -rf /var/run/apache2/*

httpd -DFOREGROUND
