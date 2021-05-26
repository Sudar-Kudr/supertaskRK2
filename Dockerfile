FROM ubuntu:20.04

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update
RUN apt install -yy gcc g++ cmake git vim

COPY . ~/workspace/projects/supertaskRK2
WORKDIR ~/workspace/projects/supertaskRK2

RUN cmake -H. -B_build -DCMAKE_INSTALL_PREFIX=_install -DBUILD_TESTS=ON
RUN cmake --build _build --target install

RUN cmake --build _build --target test

#ENTRYPOINT ./demo
