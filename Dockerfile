FROM n8nio/n8n:latest

USER root

# Installer Python et pip
RUN apk add --update --no-cache \
    python3 \
    python3-dev \
    py3-pip \
    gcc \
    musl-dev \
    linux-headers \
    g++ \
    make \
    libffi-dev \
    openssl-dev

# Créer un lien symbolique pour python
RUN ln -sf python3 /usr/bin/python

# Installer Playwright et ses dépendances système
RUN apk add --no-cache \
    chromium \
    chromium-chromedriver \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Installer les packages Python
RUN pip3 install --no-cache-dir \
    crawl4ai \
    playwright \
    beautifulsoup4 \
    lxml \
    requests

# Installer les navigateurs Playwright
RUN playwright install chromium
RUN playwright install-deps

# Variables d'environnement pour Playwright
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=0

USER node

EXPOSE 5678

CMD ["n8n"]