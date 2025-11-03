ARG BASE_IMAGE=visa-image

FROM $BASE_IMAGE

RUN STRICT_MODE=true node install-package-cli.js aws az infracost terratag
