FROM alpine
RUN apk update && \
    apk add openrc && \
    apk add docker && \
    apk add bash
RUN apk update && \
    rc-update add docker boot
