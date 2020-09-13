FROM node:11 as build

ADD . /pluto-admin

WORKDIR /pluto-admin

RUN rm -rf node_modules/ && rm -rf package-lock.json && npm install
RUN npm run build:prod

FROM python:3.9-rc-alpine

COPY --from=build /pluto-admin/dist /pluto-admin/dist

WORKDIR /pluto-admin/dist

ENTRYPOINT python3 -m http.server 8012
