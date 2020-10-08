ARG base
FROM ${base}

RUN apt-get update && \
    apt-get install -y -q \
        g++ \
        gcc \
        # These two are for aws-sdk-cpp
        libcurl4-openssl-dev \
        libssl-dev \
        make \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# apt-get cmake is too old on 16.04
ARG cmake=3.18.1
RUN wget -nv -O - https://github.com/Kitware/CMake/releases/download/v${cmake}/cmake-${cmake}-Linux-x86_64.tar.gz | tar -xzf - -C /opt
ENV PATH=/opt/cmake-${cmake}-Linux-x86_64/bin:$PATH

ENV ARROW_R_DEV=TRUE
