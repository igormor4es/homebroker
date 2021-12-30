FROM node:lts-alpine as build
WORKDIR /usr/src

RUN apk --no-cache add git \
	&& git clone https://github.com/igormor4es/homebroker.git \
	&& cd homebroker \
	&& npm ci \
	&& npm run build \
	&& apk --no-cache del git

FROM nginx:latest

COPY --from=build /usr/src/homebroker/dist/homebroker /usr/share/nginx/html
