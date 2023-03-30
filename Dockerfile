FROM ghcr.io/gatzka/docker-cxx-ci:new_compilers
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
