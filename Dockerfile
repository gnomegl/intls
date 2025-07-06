FROM archlinux:latest

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    ca-certificates \
    jq \
    && pacman -Scc --noconfirm

WORKDIR /app

COPY arch-binaries/curl /usr/local/bin/curl
COPY arch-binaries/libcurl.so.4 /usr/local/lib/libcurl.so.4
COPY arch-binaries/libnghttp3.so.9 /usr/local/lib/libnghttp3.so.9
COPY arch-binaries/libunistring.so.5 /usr/local/lib/libunistring.so.5

RUN chmod +x /usr/local/bin/curl && \
    ldconfig

COPY bin/intls /app/intls

RUN chmod +x /app/intls

RUN mkdir -p /root/.config

ENV PATH="/usr/local/bin:${PATH}"

ENTRYPOINT ["/app/intls"]
