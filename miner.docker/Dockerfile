FROM nvidia/cuda:9.0-devel-ubuntu16.04

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install vim wget

RUN mkdir /apps /build

RUN mkdir /build/ccminer
RUN wget -q -O - https://bcamp.sh/ccminer-2.2.4-xenial-cuda9/ccminer-2.2.4-xenial-cuda9.tar.gz | tar -zxvf - -C /build/ccminer
RUN [ $(sha256sum /build/ccminer/ccminer-2.2.4-xenial-cuda9 | sed 's/ .*//') = 4ac48238ea2d2beab7a2f969cded0f84c6ee3e5d213f8495590eff034d19e1fe ]
RUN cp /build/ccminer/ccminer-2.2.4-xenial-cuda9 /apps/ccminer
RUN apt-get -y install libcurl3

RUN mkdir /build/dstm
RUN wget -q -O - 'https://docs.google.com/uc?export=download&id=19fSFYqoeOhOkxQqKnGpNI3n-7TIppHnq' | tar -zxvf - -C /build/dstm
RUN [ $(sha1sum /build/dstm/zm_0.5.8/zm | sed 's/ .*//') = '827b137e061fe1da8f8fbcea12cec22449d3ae13' ]
RUN cp /build/dstm/zm_0.5.8/zm /apps/dstm

RUN mkdir /build/ethminer
RUN wget -q -O - https://github.com/ethereum-mining/ethminer/releases/download/v0.13.0rc2/ethminer-0.13.0rc2-Linux.tar.gz | tar -zxvf - -C /build/ethminer
RUN [ $(sha256sum /build/ethminer/bin/ethminer | sed 's/ .*//') = 5a90c1c3af9d32de6bfe532ca9039298799c81ac85b8bdb88c08c7c0540fd0fc ]
RUN cp /build/ethminer/bin/ethminer /apps/ethminer

RUN mkdir /build/excavator
RUN wget -P /build/excavator https://github.com/nicehash/excavator/releases/download/v1.3.8a/excavator_1.3.8a-xenial0_amd64.deb
RUN [ $(sha256sum /build/excavator/excavator_1.3.8a-xenial0_amd64.deb | sed 's/ .*//') = 531f7873d1523676d78e0c7736c6ea009d47722930988f8b51bc3236efa0ceb0 ]
RUN apt-get -y install /build/excavator/excavator_1.3.8a-xenial0_amd64.deb
ADD excavator-start /apps/excavator-start

RUN mkdir /build/ewfb
RUN wget -q -O - https://github.com/nanopool/ewbf-miner/releases/download/v0.3.4b/Zec.miner.0.3.4b.Linux.Bin.tar.gz | tar -zxvf - -C /build/ewfb
RUN [ $(sha256sum /build/ewfb/miner | sed 's/ .*//') = 321b97bb1c64bea817e57f616db50fa3908c5c622708ccf93ecfb173e7db0aee ]
RUN cp /build/ewfb/miner /apps/ewfb

RUN mkdir /build/xmrig
RUN wget -q -O - https://github.com/xmrig/xmrig/releases/download/v2.4.3/xmrig-2.4.3-gcc7-xenial-amd64-no-api.tar.gz | tar -zxvf - -C /build/xmrig
RUN [ $(sha256sum /build/xmrig/xmrig-2.4.3/xmrig | sed 's/ .*//') = f3f2703a7959183b010d808521b531559650f6f347a5830e47f8e3831b10bad5 ]
RUN cp /build/xmrig/xmrig-2.4.3/xmrig /apps

RUN useradd --uid 3000 --create-home miner

ADD mine /usr/bin/mine

VOLUME /config
