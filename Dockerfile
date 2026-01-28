FROM alpine:latest AS alpine_base

FROM n8nio/n8n:latest

# Step 1: Restore apk by copying it from a fresh Alpine image
COPY --from=alpine_base /sbin/apk /sbin/
COPY --from=alpine_base /usr/lib/libapk.so* /usr/lib/

USER root

# Step 2: Install Python and pip (plus any other packages you need)
RUN apk add --no-cache python3 py3-pip && \
    python3 -m ensurepip --upgrade

# Step 3: Continue with your original setup
WORKDIR /home/node/packages/cli
ENTRYPOINT []

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
