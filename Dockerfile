#FROM docker.pkg.github.com/gatzka/docker-c-ci/docker-c-ci:1.0.0
FROM gatzka/gh-c-ci:1.0.0
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
