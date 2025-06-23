FROM debian:bullseye

RUN apt update && apt install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY tools/init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init.sh

ENTRYPOINT ["/usr/local/bin/init.sh"]
