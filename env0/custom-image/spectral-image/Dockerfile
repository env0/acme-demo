ARG BASE_TAG=latest

FROM ghcr.io/env0/deployment-agent:${BASE_TAG}

ARG TARGETARCH
ARG WIZCLI_VERSION=0.100.0
ARG USER_ID=1001210001
ENV USER_UID=${USER_ID}
ENV ENV0_AWS_VERSION=2.31.27
ENV ENV0_AZ_VERSION=2.78.0

RUN echo "Building for architecture: ${TARGETARCH}"

RUN curl -sL -o /tmp/wizcli https://downloads.wiz.io/wizcli/${WIZCLI_VERSION}/wizcli-linux-${TARGETARCH} && \
    curl -sL -o /tmp/public_key.asc https://downloads.wiz.io/wizcli/public_key.asc && \
    curl -sL -o /tmp/wizcli-sha256 https://downloads.wiz.io/wizcli/${WIZCLI_VERSION}/wizcli-linux-${TARGETARCH}-sha256 && \
    curl -sL -o /tmp/wizcli-sha256.sig https://downloads.wiz.io/wizcli/${WIZCLI_VERSION}/wizcli-linux-${TARGETARCH}-sha256.sig && \
    gpg --import /tmp/public_key.asc && \
    gpg --verify /tmp/wizcli-sha256.sig /tmp/wizcli-sha256 && \
    echo "$(cat /tmp/wizcli-sha256) /tmp/wizcli" | sha256sum -c && \
    mv /tmp/wizcli /usr/local/bin/wizcli && \
    chmod +x /usr/local/bin/wizcli && \
    rm -f /tmp/public_key.asc /tmp/wizcli-sha256 /tmp/wizcli-sha256.sig && \
    wizcli version

# Modify IDS
RUN apk add -U shadow \
    && usermod -u ${USER_ID} node \
    && apk del -U shadow

#add spectral
RUN mkdir /home/node/.spectral
COPY ./spectral /home/node/.spectral
RUN chmod 777 /home/node/.spectral/spectral
