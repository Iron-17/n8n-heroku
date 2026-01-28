FROM alpine:latest AS alpine_base

FROM n8nio/n8n:latest

# Copy apk and its deps from Alpine
COPY --from=alpine_base /sbin/apk /sbin/
COPY --from=alpine_base /usr/lib/libapk.so* /usr/lib/

USER root

# 1. Install Python and pip
RUN apk add --no-cache python3 py3-pip

# 2. Upgrade pip and install the venv module
RUN python3 -m ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel

# 3. Create a virtual environment in /opt/venv
RUN python3 -m venv /opt/venv

# 4. Install packages *inside* the virtual environment
# Install any packages you need here, e.g., pandas, requests
RUN /opt/venv/bin/pip install --no-cache-dir pandas

# Continue with your original setup
WORKDIR /home/node/packages/cli
ENTRYPOINT []

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
