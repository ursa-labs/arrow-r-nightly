ARG base
FROM ${base}

RUN yum install -y \
        bison \
        flex \
        g++ \
        gcc \
        gcc-c++ \
        make \
        wget \
        which

# yum install cmake version is too old

ARG cmake=3.16.2
RUN wget -nv -O - https://github.com/Kitware/CMake/releases/download/v${cmake}/cmake-${cmake}-Linux-x86_64.tar.gz | tar -xzf - -C /opt
ENV PATH=/opt/cmake-${cmake}-Linux-x86_64/bin:$PATH
ENV CC=/usr/bin/gcc
ENV CXX=/usr/bin/g++
ENV EXTRA_CMAKE_FLAGS="-DCMAKE_C_COMPILER=$CC -DCMAKE_CXX_COMPILER=$CXX"
