FROM golang:latest AS builder
WORKDIR /app
COPY ./stream/ .
RUN go mod download && go mod tidy 
RUN go build -ldflags='-s -w' stream

FROM node:latest AS server
WORKDIR /app
COPY . . 
COPY --from=builder /app/stream /app/server/stream/stream
CMD ["npm", "run", "start"]
