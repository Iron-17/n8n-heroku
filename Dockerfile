FROM alpine:latest AS alpine_base

FROM n8nio/n8n:latest

# Copy apk and its deps from Alpine (this part is correct)
COPY --from=alpine_base /sbin/apk /sbin/
COPY --from=alpine_base /usr/lib/libapk.so* /usr/lib/

USER root

# 1. Install Python using apk
RUN apk add --no-cache python3

# 2. Create the Python virtual environment
RUN python3 -m venv /opt/venv

# 3. Install packages USING THE VENV'S PIP
# Replace 'pandas' with any packages you need
RUN /opt/venv/bin/pip install --no-cache-dir --upgrade pip setuptools wheel
RUN /opt/venv/bin/pip install --no-cache-dir pandas

# 4. Add the venv to the PATH for the entire container
ENV PATH="/opt/venv/bin:$PATH"

# Continue with your original setup
WORKDIR /home/node/packages/cli
ENTRYPOINT []

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
