FROM amazonlinux

RUN yum -y update && \
    yum -y install httpd php mysql php-mysql wget tar.x86_64 mod_ssl

WORKDIR /var/www/html

RUN wget https://s3-us-west-2.amazonaws.com/us-west-2-aws-training/awsu-spl/spl-13/scripts/app.tgz

RUN tar xvfz app.tgz

RUN chown apache:root /var/www/html/rds.conf.php

EXPOSE 80 443 3306

COPY ./efs/container-ssl/ssl.conf /etc/httpd/conf.d/
COPY ./efs/container-ssl/certificate.crt /root/
COPY ./efs/container-ssl/private.key /root/
COPY ./efs/container-ssl/ca_bundle.crt /root/

CMD apachectl -D FOREGROUND
