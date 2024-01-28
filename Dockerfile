FROM node:11 as build

ADD . /pluto-admin

WORKDIR /pluto-admin

RUN git config --global http.sslverify "false"
RUN git config --global url."https://".insteadOf "git://"
RUN rm -rf node_modules/ && rm -rf package-lock.json && npm install
RUN npm run build:prod

FROM python:3.9-rc

COPY --from=build /pluto-admin/dist /app
COPY docker-entrypoint.sh /usr/local
RUN chmod +x /usr/local/docker-entrypoint.sh

ENV VUE_APP_BASE_API="http://localhost:8081/"
ENV PORT=8082

ENTRYPOINT ["/usr/local/docker-entrypoint.sh"]
