ARG ALPINE_VERSION=3.19
ARG BASE_TAG=3.0.804
ARG BASE_IMAGE=ghcr.io/env0/deployment-agent-lean
FROM python:3.11-alpine${ALPINE_VERSION} AS builder

ARG AWS_CLI_VERSION=2.22.18
RUN apk add --no-cache git unzip groff build-base libffi-dev cmake
RUN git clone --depth 1 -b ${AWS_CLI_VERSION} --single-branch https://github.com/aws/aws-cli.git

RUN cd aws-cli \
    && ./configure --with-install-type=portable-exe --with-download-deps \
    && make \
    && make install

# reduce image size: remove autocomplete and examples
RUN rm -rf \
    /usr/local/lib/aws-cli/aws_completer \
    /usr/local/lib/aws-cli/awscli/data/ac.index \
    /usr/local/lib/aws-cli/awscli/examples
RUN find /usr/local/lib/aws-cli/awscli/data -name completions-1*.json -delete
RUN find /usr/local/lib/aws-cli/awscli/botocore/data -name examples-1.json -delete
RUN (cd /usr/local/lib/aws-cli; for a in *.so*; do test -f /lib/$a && rm $a; done)

# copy aws v2 cli to the final image
FROM ${BASE_IMAGE}:${BASE_TAG} AS final-image
COPY --from=builder /usr/local/lib/aws-cli/ /usr/local/lib/aws-cli/v2
RUN ln -s /usr/local/lib/aws-cli/v2/aws /usr/local/bin/awsv2
RUN ln -s /usr/local/lib/aws-cli/v2/aws /usr/local/bin/aws
RUN aws --version

USER root

#Install Python for Azure CLI
RUN apk add --no-cache \
        python3 \
        python3-dev \
    && python3 -m venv --system-site-packages --upgrade-deps /opt/global_python_venv

ENV PATH="/opt/global_python_venv/bin:${PATH}"

ARG AZ_CLI_VERSION=2.67.0
# Install Azure cli
RUN apk add --virtual=build gcc make openssl-dev libffi-dev musl-dev linux-headers \
    && pip3 install --no-cache-dir azure-cli==${AZ_CLI_VERSION} \
    && apk del --purge build \
    && az --version

ARG INFRACOST_VERSION=0.10.41
# Install infracost
RUN curl -sL https://github.com/infracost/infracost/releases/download/v${INFRACOST_VERSION}/infracost-linux-amd64.tar.gz | tar xz  && \
mv infracost-linux-amd64 /opt/infracost

ARG TERRATAG_VERSION=0.5.3
# Install Terratag
RUN npm -g install "@env0/terratag@$TERRATAG_VERSION" \
&& mv /usr/local/lib/node_modules/@env0/terratag/terratag /opt/terratag \
&& chown -R node /opt/terratag \
    # Verifies terratag installation
&& /opt/terratag -h

# Install tgenv
ARG TGENV_VERSION=0.0.9
RUN git clone --branch v${TGENV_VERSION} https://github.com/env0/tgenv.git /opt/tgenv
ENV PATH="/opt/tgenv/bin:${PATH}"
RUN chown -R node /opt/tgenv

# Install OpenSSL
RUN apk add --no-cache openssl

ARG USER_ID=1001210001
# Modify user ID User
RUN apk add --no-cache -U shadow
RUN usermod -u ${USER_ID} node
RUN apk del -U shadow

#add spectral
RUN mkdir /home/node/.spectral
COPY ./spectral /home/node/.spectral
RUN chmod 777 /home/node/.spectral/spectral