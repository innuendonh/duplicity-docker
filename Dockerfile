FROM python:2.7

RUN apt-get update \
    && apt-get install -y lftp libpar2-dev librsync-dev par2 rsync \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    PyDrive \
    azure-storage \
    boto \
    fasteners \
    lockfile \
    mediafire \
    mega.py \
    paramiko \
    pycryptopp \
    python-keystoneclient \
    python-swiftclient \
    requests \
    requests_oauthlib \
    urllib3

ENV DUPLICITY_VERSION 0.7.13.1
ENV DUPLICITY_URL https://code.launchpad.net/duplicity/0.7-series/$DUPLICITY_VERSION/+download/duplicity-$DUPLICITY_VERSION.tar.gz
ENV DUPLY_VERSION 1.11.3
ENV DUPLY_URL "https://sourceforge.net/projects/ftplicity/files/duply%20%28simple%20duplicity%29/1.11.x/duply_$DUPLY_VERSION.tgz/download"

RUN cd /tmp \
    && wget $DUPLICITY_URL \
    && tar xf duplicity-$DUPLICITY_VERSION.tar.gz \
    && cd duplicity-$DUPLICITY_VERSION && python2 setup.py install \
    && cd /tmp \
    && wget "$DUPLY_URL" -O "duply_$DUPLY_VERSION.tgz" \
    && tar xpf duply_$DUPLY_VERSION.tgz \
    && cp -a duply_$DUPLY_VERSION/duply /usr/bin/duply \
    && cd / && rm -rf /tmp/*

