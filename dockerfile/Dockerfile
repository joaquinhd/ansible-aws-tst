FROM ubuntu/18.04

USER root

RUN apt-get update -y

RUN apt-get install -y vim nginx curl

RUN service nginx start

RUN echo "<html><head><title>Hello Docker world</title></head> <body><h1>Hello World</h1> <p>Hey! Whats going on?!</p></body></html>" > /var/www/html/index.html

CMD nginx -g 'daemon off;'

EXPOSE 80 8181

