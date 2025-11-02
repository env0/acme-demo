ARG BASE_TAG=latest

FROM ghcr.io/env0/deployment-agent:{BASE_TAG}

# should be removed
# RUN node install-package-cli.js aws az infracost terratag

# Define the version/tag for Wiz CLI
ARG WIZCLI_VERSION=0.100.0
ARG TARGETARCH

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

ARG USER_ID=1001210001
# Modify user ID User
RUN apk add --no-cache -U shadow
RUN usermod -u ${USER_ID} node
RUN apk del -U shadow

#add spectral
RUN mkdir /home/node/.spectral
COPY ./spectral /home/node/.spectral
RUN chmod 777 /home/node/.spectral/spectral
