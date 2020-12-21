FROM ruby:alpine

RUN apk update
RUN apk add --no-cache curl \
    file \
    imagemagick \
    libwebp-tools \
    nodejs \
    nodejs-npm \
    pngcrush \
    optipng \
    pngquant \
    jpegoptim \
    gifsicle \
    advancecomp \
    libjpeg-turbo-utils \
    git \
    automake \
    autoconf \
    pkgconfig \
    nasm \
    libtool \
    build-base \
    cmake \
    libpng \
    tar

RUN apk add jhead --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN curl -O https://www.jonof.id.au/files/kenutils/pngout-20200115-linux-static.tar.gz
RUN tar zxf pngout-20200115-linux-static.tar.gz
RUN cp -f pngout-20200115-linux-static/amd64/pngout-static /usr/local/bin/pngout

RUN apk add --virtual build-dependencies build-base

RUN npm install -g svgo

ENV MOZJPEG_VERSION='v3.3.1'
RUN curl https://codeload.github.com/mozilla/mozjpeg/tar.gz/$MOZJPEG_VERSION > mozjpeg.tar.gz
RUN tar zxf mozjpeg.tar.gz
RUN rm mozjpeg.tar.gz
RUN SRC_DIR=$(ls -t1 -d mozjpeg-* | head -n1) && \
    cd $SRC_DIR && \
    autoreconf -fiv && \
    cd .. && \
    sh $SRC_DIR/configure && \
    make install
RUN rm -rf $(ls -t1 -d mozjpeg-* | head -n1)

ENV JPEG_ARCHIVE_VERSION='v2.2.0'
RUN curl https://codeload.github.com/danielgtaylor/jpeg-archive/tar.gz/$JPEG_ARCHIVE_VERSION > jpeg-archive.tar.gz
RUN tar zxf jpeg-archive.tar.gz
RUN rm jpeg-archive.tar.gz
RUN cd $(ls -t1 -d jpeg-archive-* | head -n1) \
    && make \
    && make install
RUN rm -rf $(ls -t1 -d jpeg-archive-* | head -n1)

RUN gem install image_optim image_optim_pack

RUN mkdir -p /app/input /app/output
WORKDIR /app
COPY run.sh /app/
COPY .image_optim.yml /app/
RUN chmod +x /app/run.sh


CMD ["/app/run.sh"]
