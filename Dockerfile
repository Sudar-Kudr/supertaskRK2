FROM ubuntu:20.04

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update
RUN apt install -yy git g++ cmake vim
RUN mkdir -p ~/workspace/projects/supertaskRK2
WORKDIR ~/workspace/projects/supertaskRK2
RUN git clone https://github.com/Sudar-Kudr/supertaskRK2.git .

RUN cmake -H. -B_build -DCMAKE_INSTALL_PREFIX=_install -DBUILD_TESTS=ON
RUN cmake --build _build --target install

RUN cmake --build _build --target test

#ENTRYPOINT ./demo
