FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    build-essential git cmake wget gcc-5 g++-5 clang-3.8 \
    libeigen3-dev libglew-dev libc++-dev libwayland-dev libxkbcommon-dev libegl1-mesa-dev \
    libgtk2.0-dev libgtk-3-dev libglfw3-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libusb-1.0-0-dev
RUN cd /opt && git clone --branch 3.4 https://github.com/opencv/opencv.git
RUN cd /opt/opencv && mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make -j8 install
RUN cd /opt && git clone https://github.com/stevenlovegrove/Pangolin.git
RUN cd /opt/Pangolin && mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make -j8 install
RUN cd /opt && git clone https://github.com/IntelRealSense/librealsense.git
RUN cd /opt/librealsense && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make -j8 install
RUN cd /opt && git clone https://github.com/zeromq/libzmq.git
RUN cd /opt/libzmq && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DZMQ_BUILD_TESTS=OFF .. && make -j8 install
RUN cd /opt && git clone https://github.com/zeromq/cppzmq.git
RUN cd /opt/cppzmq && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DCPPZMQ_BUILD_TESTS=OFF .. && make -j8 install
