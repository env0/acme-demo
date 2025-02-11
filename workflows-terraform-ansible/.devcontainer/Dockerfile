FROM mcr.microsoft.com/devcontainers/universal:2-linux
ARG TERRAFORM_VERSION=1.5.7
USER root
# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
mv terraform /usr/bin && \
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
# Install Ansible
pip3 install --user ansible && \
# Install AWS
pip install --upgrade pip && \
pip install --upgrade awscli
USER codespace