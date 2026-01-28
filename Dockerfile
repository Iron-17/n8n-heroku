FROM n8nio/n8n:latest

USER root

# --- ADD THESE LINES TO INSTALL PYTHON ---
RUN apk add --update --no-cache python3 py3-pip && \
    python3 -m ensurepip --upgrade
# -----------------------------------------

WORKDIR /home/node/packages/cli
ENTRYPOINT []

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
