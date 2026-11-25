# ---- build stage ----
FROM node:22-alpine AS build
WORKDIR /app

# Install dependencies (npm peer-resolution workaround for npm 11 + vitest graph).
COPY package.json package-lock.json ./
RUN npm ci --legacy-peer-deps --no-audit --no-fund

# Build the production bundle.
COPY . .
RUN npm run build

# ---- runtime stage ----
FROM nginxinc/nginx-unprivileged:1.27-alpine AS runtime

# Unprivileged image runs as uid 101 and listens on 8080.
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Angular v17+ builder emits to dist/<project>/browser.
COPY --from=build /app/dist/frontend/browser /usr/share/nginx/html

EXPOSE 8080

# config.json is overridden at runtime (mounted by docker-compose), so a single
# image works in every environment.
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://127.0.0.1:8080/ >/dev/null 2>&1 || exit 1
