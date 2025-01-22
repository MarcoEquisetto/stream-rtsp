FROM golang:latest as builder
WORKDIR /app
COPY ./server/stream/ ./go_server
RUN cd go_server && go mod tidy && go mod download
RUN go build -ldflags='-s -w' ./go_server -o stream 

FROM node:latest 
WORKDIR /app
COPY . . 
COPY --from=builder /app/stream /app/server/stream/stream
CMD ["npm", "start"]