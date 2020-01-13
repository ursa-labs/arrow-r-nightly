ARG base
FROM ${base}

RUN apt-get update && \
    apt-get install -y -q \
        bison \
        flex \
        g++ \
        gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# apt-get cmake is too old on 16.04
ARG cmake=3.16.2
RUN wget -nv -O - https://github.com/Kitware/CMake/releases/download/v${cmake}/cmake-${cmake}-Linux-x86_64.tar.gz | tar -xzf - -C /opt
ENV PATH=/opt/cmake-${cmake}-Linux-x86_64/bin:$PATH
