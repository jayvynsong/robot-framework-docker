FROM python:3.12.0a5-alpine3.17

LABEL Maintainer="JayvynSong<songxiaojie_2005@163.com>" Version="1.0"

RUN apk add --no-cache \
    gcc \
    musl-dev \
    libffi-dev \
    # for Chrome
    # eudev \
    # chromium \
    # chromium-chromedriver \
    # for firefox
    # dbus \
    # font-freefont \
    # firefox-esr \
    # ---
    xvfb && \
    pip install --no-cache-dir \
    robotframework==6.0.2 \
    robotframework-seleniumlibrary==6.0.0 \
    robotframework-sshlibrary==3.8.0 \
    selenium==4.8.2 && \
    apk del \
    gcc \ 
    musl-dev \
    libffi-dev
    # for firefox : selenium==2.53.6

# For firefox
#RUN cd /tmp && \
#    wget https://github.com/mozilla/geckodriver/releases/download/v0.23.0/geckodriver-v0.23.0-arm7hf.tar.gz && \
#    tar -xvzf geckodriver* && \
#    chmod +x geckodriver && \
#    mv geckodriver /usr/local/bin/ && \
#    export PATH=$PATH:/usr/local/bin/geckodriver


# Chrome requires docker to have cap_add: SYS_ADMIN if sandbox is on.
# Disabling sandbox and gpu as default.
# RUN sed -i "s/self._arguments\ =\ \[\]/self._arguments\ =\ \['--no-sandbox',\ '--disable-gpu'\]/" /usr/local/lib/python3.12/site-packages/selenium/webdriver/common/options.py

RUN rm -rf /var/cache/apk/*
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh

ENV SCREEN_WIDTH 1280
ENV SCREEN_HEIGHT 720
ENV SCREEN_DEPTH 16

ENTRYPOINT [ "/opt/bin/entry_point.sh" ]
