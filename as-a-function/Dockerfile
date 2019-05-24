FROM ubuntu:18.04

# Installing dependencies
RUN apt update
RUN apt install -y cmake \
                   libtiff5-dev \
                   libpng-dev \
                   libjpeg-dev \
                   libcairo2-dev \
                   libopenjp2-7-dev \
                   git

# Clone the repo
RUN git clone https://anongit.freedesktop.org/git/poppler/poppler.git

# Build
RUN mkdir poppler/build
WORKDIR poppler/build
RUN cmake -E env CXXFLAGS="-static-libstdc++" cmake ..
RUN make
