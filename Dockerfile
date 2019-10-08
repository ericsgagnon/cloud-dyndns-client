# forked from github.com/ianlewis/cloud-dyndns-client
# updated to use go modules

FROM golang:1.13 as build

COPY . /src

RUN cd /src/cmd/cloud-dyndns-client && go build -o /src/cloud-dyndns-client main.go 

FROM alpine:3 as final

COPY --from=build /src/cloud-dyndns-client /cloud-dyndns-client

RUN apk add --no-cache ca-certificates

VOLUME /etc/cloud-dyndns-client

EXPOSE 8080

CMD ["/cloud-dyndns-client"]
