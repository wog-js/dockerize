FROM node:12.20.1-alpine3.12

WORKDIR /app

# extract latest distribution
COPY src/dist/* ./
COPY docker-scripts/extract.sh ./
RUN chmod +x extract.sh
RUN ./extract.sh
RUN rm extract.sh

# remove unneeded files
RUN rm .env.example CHANGELOG.md ecosystem.config.js

RUN apk add --no-cache python3 make g++
RUN npm ci --only=production
RUN apk del python3 make g++

RUN adduser -S -D -H -h /app -s /sbin/nologin wog
USER wog
EXPOSE 8082
CMD [ "node", "backend/main.js" ]
