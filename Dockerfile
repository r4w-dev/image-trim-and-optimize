FROM ruby:alpine

RUN apk update
RUN apk add --no-cache curl file imagemagick libwebp-tools nodejs nodejs-npm pngcrush optipng pngquant jpegoptim gifsicle advancecomp libjpeg-turbo-utils
RUN apk add jhead --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN curl -O https://www.jonof.id.au/files/kenutils/pngout-20200115-linux-static.tar.gz
RUN tar zxf pngout-20200115-linux-static.tar.gz
RUN cp -f pngout-20200115-linux-static/amd64/pngout-static /usr/local/bin/pngout

RUN npm install -g svgo

RUN gem install image_optim image_optim_pack

RUN mkdir -p /app/input /app/output
WORKDIR /app
COPY run.sh /app/
RUN chmod +x /app/run.sh


CMD ["/app/run.sh"]