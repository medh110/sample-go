#build
FROM golang:1.23-alpine AS build
WORKDIR /app
COPY go.mod  ./
RUN go mod download && go mod tidy
COPY . /app
RUN go build -o sample-go

#deploy
FROM alpine:latest
WORKDIR /app
COPY --from=build /app/sample-go /app/sample-go
COPY --from=build /app/templates /app/templates
EXPOSE 8080
CMD ["./sample-go"]