FROM nvidia/cuda:9.0-runtime-ubuntu16.04

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install vim wget

RUN mkdir /apps /build

RUN mkdir /build/ethminer
RUN wget -q -O - https://github.com/ethereum-mining/ethminer/releases/download/v0.13.0rc2/ethminer-0.13.0rc2-Linux.tar.gz | tar -zxvf - -C /build/ethminer
RUN [ $(sha256sum /build/ethminer/bin/ethminer | sed 's/ .*//') = 5a90c1c3af9d32de6bfe532ca9039298799c81ac85b8bdb88c08c7c0540fd0fc ]
RUN install -o root -g root /build/ethminer/bin/ethminer /apps

RUN mkdir /build/excavator
RUN wget -P /build/excavator https://github.com/nicehash/excavator/releases/download/v1.3.9a/excavator_1.3.9a-xenial0_amd64.deb
RUN [ $(sha256sum /build/excavator/excavator_1.3.9a-xenial0_amd64.deb | sed 's/ .*//') = 7781e41851fc2a52322e4e07f8c51a46135d15e280fecbe2ba36ceed233c1a9a ]
RUN apt-get -y install /build/excavator/excavator_1.3.9a-xenial0_amd64.deb
ADD excavator-start /apps/excavator-start

RUN mkdir /build/xmrig
RUN wget -q -O - https://github.com/xmrig/xmrig/releases/download/v2.4.3/xmrig-2.4.3-gcc7-xenial-amd64-no-api.tar.gz | tar -zxvf - -C /build/xmrig
RUN [ $(sha256sum /build/xmrig/xmrig-2.4.3/xmrig | sed 's/ .*//') = f3f2703a7959183b010d808521b531559650f6f347a5830e47f8e3831b10bad5 ]
RUN install -o root -g root /build/xmrig/xmrig-2.4.3/xmrig /apps

RUN useradd --uid 3000 --create-home miner

ADD mine /usr/bin/mine
