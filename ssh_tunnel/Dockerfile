ARG BUILD_FROM
FROM $BUILD_FROM

LABEL maintainer="arthurmb@gmail.com"
LABEL image="ssh_tunnel_$BUILD_ARCH"
LABEL io.hass.version="$BUILD_VERSION" io.hass.type="addon" io.hass.arch="$BUILD_ARCH"

ENV LANG C.UTF-8
ENV AUTOSSH_PORT 0

RUN apk add --no-cache openssh autossh

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
