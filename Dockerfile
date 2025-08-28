FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates curl iputils-ping && \
    wget -qO /etc/apt/trusted.gpg.d/nordvpn_public.asc https://repo.nordvpn.com/gpg/nordvpn_public.asc && \
    echo "deb https://repo.nordvpn.com/deb/nordvpn/debian stable main" > /etc/apt/sources.list.d/nordvpn.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends nordvpn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT /etc/init.d/nordvpn start && sleep 5 && /bin/bash -c "$@"

COPY /rootfs/usr/bin /usr/bin
#RUN chmod +x /usr/bin/nord_login /usr/bin/nord_config /usr/bin/nord_mesh /usr/bin/nord_mesh_config /usr/bin/nord_watch
RUN chmod +x /usr/bin/nord_login /usr/bin/nord_config /usr/bin/nord_mesh /usr/bin/nord_mesh_config /usr/bin/nord_watch /usr/bin/dockerNetworks

CMD bash
#CMD nord_login && nord_config && nord_mesh && nord_mesh_config && nord_watch
#CMD nord_login && nord_config && nord_mesh && nord_watch


CMD nord_login && nord_mesh && nord_mesh_config && nord_watch
