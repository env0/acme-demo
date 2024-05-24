# Use the env0 image as the base image
FROM ghcr.io/env0/deployment-agent-lean:3.0.750
 
USER root
 
ARG GLIBC_VER=2.35-r1
RUN apk add --no-cache \
        binutils \
        groff \
&& curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
&& curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
&& curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
&& curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-i18n-${GLIBC_VER}.apk \
&& apk add --no-cache --force-overwrite \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
        glibc-i18n-${GLIBC_VER}.apk \
&& /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
&& rm -rf \
        glibc-*.apk \
        /var/cache/apk/*
 
# Install aws cli v2
RUN curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
&& unzip -q awscliv2.zip \
&& aws/install -i /usr/local/aws-cli-v2 -b /usr/local/bin/aws-cli-v2 \
&& rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/current/dist/aws_completer \
        /usr/local/aws-cli/v2/current/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/current/dist/awscli/examples \
&& ln -s /usr/local/bin/aws-cli-v2/aws /usr/local/bin/aws \
&& ln -s /usr/local/bin/aws-cli-v2/aws /usr/local/bin/awsv2 # AWS CLI should be saved as "awsv2" for Cloudformation templates 

RUN aws --version
 
# Install infracost
ARG INFRACOST_VERSION=0.10.36
RUN curl -sL https://github.com/infracost/infracost/releases/download/v${INFRACOST_VERSION}/infracost-linux-amd64.tar.gz | tar xz  && \
mv infracost-linux-amd64 /opt/infracost
 
# Install Terratag
ARG TERRATAG_VERSION=0.3.4
RUN npm -g install "@env0/terratag@$TERRATAG_VERSION" \
&& mv /usr/local/lib/node_modules/@env0/terratag/terratag /opt/terratag \
&& chown -R node /opt/terratag \
    # Verifies terratag installation
&& /opt/terratag -h

# Install OpenSSL
RUN apk add --no-cache openssl

# Modify user ID User
RUN apk add --no-cache -U shadow
RUN usermod -u 1003050001 node
RUN apk del -U shadow