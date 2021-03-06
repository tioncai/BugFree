FROM alpine

MAINTAINER zhangxc <zhangxingcai@ghostcloud.cn>

LABEL Verdor="Ghostcloud" \
      Name="bugfree:3.3" \
      Verson="1.0.0" \
      Date="1/11/2016"

RUN echo "http://mirrors.ustc.edu.cn/alpine/latest-stable/main/" > /etc/apk/repositories
RUN apk add --update apache2 php5 php5-apache2 openrc php5-mysql php5-gd php5-ldap php5-json php5-xml php5-opcache php5-pdo_mysql php5-pdo\
    && mkdir -p /var/run/apache2 \
    && rm -rf /var/cache/apk/*

RUN sed -i 's!DocumentRoot "/var/www/localhost/htdocs"!DocumentRoot "/var/www/bugfree"!' /etc/apache2/httpd.conf \
    && sed -i 's!Directory "/var/www/localhost/htdocs"!Directory "/var/www/bugfree"!' /etc/apache2/httpd.conf \
    && sed  -i 's!/run/apache2/httpd.pid!/var/run/apache2/httpd.pid!' /etc/apache2/conf.d/mpm.conf  \
    && sed  -i 's/index.html/index.php/' /etc/apache2/httpd.conf \
    && sed  -i 's/User apache/#User apache/;s/Group apache/#Group apache/' /etc/apache2/httpd.conf \
    && echo "ServerName localhost" >> /etc/apache2/httpd.conf
    
RUN mkdir -p /var/www/bugfree \
    && mkdir -p /var/www/BugFile \
    && mkdir -p /var/www/bugfree/assets \
    && mkdir -p /var/www/bugfree/protected/runtime

COPY . /var/www/bugfree
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
