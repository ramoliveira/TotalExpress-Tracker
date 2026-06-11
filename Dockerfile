FROM alpine:latest

RUN apk add --no-cache \
    bash \
    curl \
    jq \
    ca-certificates

WORKDIR /app

COPY . .

ENTRYPOINT ["bash", "tracker.sh"]
