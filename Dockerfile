# Stage 1: Build Watchman
FROM alpine:latest AS builder

RUN apk --no-cache add \
    git \
    automake \
    autoconf \
    build-base \
    libtool

RUN git clone https://github.com/facebook/watchman.git /watchman

WORKDIR /watchman
RUN git checkout v2022.04.25.00

RUN ./autogen.sh
RUN ./configure --without-python
RUN make

# Stage 2: Final Image
FROM alpine:latest

RUN apk --no-cache add libgcc libstdc++

COPY --from=builder /watchman/watchman /usr/local/bin/

CMD ["watchman", "--version"]
