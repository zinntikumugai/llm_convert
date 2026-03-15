FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-venv \
    python3-pip \
    cmake \
    build-essential \
    ninja-build \
    pkg-config \
    ca-certificates \
    curl \
    jq \
    bash \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN git clone https://github.com/ggml-org/llama.cpp.git

WORKDIR /opt/llama.cpp

RUN python3 -m venv /opt/venv \
 && /opt/venv/bin/pip install -r requirements.txt

RUN cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release \
 && cmake --build build -j"$(nproc)"

ENV PATH="/opt/venv/bin:/opt/llama.cpp:/opt/llama.cpp/build/bin:${PATH}"

WORKDIR /work/scripts

COPY ./scripts ./

WORKDIR /work

CMD ["/bin/bash"]

