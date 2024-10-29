# syntax=docker/dockerfile:1
ARG PYTHON_VERSION=3.11
FROM python:${PYTHON_VERSION}-slim-bullseye AS base
FROM base AS builder

ENV ZEO_VERSION=6.0.0

RUN <<EOT
    set -e
    apt-get update
    apt-get -y upgrade
    buildDeps="build-essential"
    apt-get install -y --no-install-recommends $buildDeps
    python -m venv /app
EOT

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

ENV UV_LINK_MODE=copy
ENV UV_COMPILE_BYTECODE=1
ENV UV_PYTHON_DOWNLOADS=never
ENV UV_PYTHON=python${PYTHON_VERSION}
ENV UV_PROJECT_ENVIRONMENT=/app

RUN --mount=type=cache,target=/root/.cache <<EOT
    set -e
    uv pip install --python=$UV_PROJECT_ENVIRONMENT "zeo==${ZEO_VERSION}"
EOT

FROM base

LABEL maintainer="Plone Community <dev@plone.org>" \
      org.label-schema.name="plone-zeo" \
      org.label-schema.description="ZEO (ZODB) Server." \
      org.label-schema.vendor="Plone Foundation"

COPY --from=builder /app /app

RUN <<EOT
    set -e
    useradd --system -m -d /app -U -u 500 plone
    mkdir -p /data /app/var
    chown -R plone:plone /app /data
EOT

WORKDIR /app
USER plone

COPY start-zeo.sh /app/start-zeo.sh
COPY etc /app/etc

EXPOSE 8100
VOLUME /data

CMD ["/app/start-zeo.sh"]
