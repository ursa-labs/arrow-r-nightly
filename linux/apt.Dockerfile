ARG base
FROM ${base}

RUN apt-get update && \
    apt-get install -y -q \
        bison \
        cmake \
        flex \
        g++ \
        gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
