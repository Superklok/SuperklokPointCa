FROM node:17.2.0-alpine3.14 as base
LABEL org.opencontainers.image.vendor="Superklok Labs"
LABEL org.opencontainers.image.authors="trev@superklok.ca"
LABEL org.opencontainers.image.title="SuperklokPointCa"
LABEL org.opencontainers.image.description="Superklok Labs (Français)"
LABEL org.opencontainers.image.version="1.11.5"
LABEL org.opencontainers.image.created="2021-12-12"
LABEL org.opencontainers.image.url="https://hub.docker.com/r/superklok/superklokpointca"
LABEL org.opencontainers.image.source="https://github.com/Superklok/SuperklokPointCa"
LABEL org.opencontainers.image.licenses="ISC"
ENV NODE_ENV=production
WORKDIR /usr/src/app
EXPOSE 80
ENV PORT 80
COPY package*.json ./
RUN npm i
COPY . .
CMD ["npm", "start"]

FROM base as dev
ENV NODE_ENV=development
USER node

FROM dev as test
RUN npm audit
USER root

FROM base as prod
USER node