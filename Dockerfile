FROM golang:1.22.5 as base
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o main .
 # Final stage with Distro less image
FROM gcr.io/distroless/base
COPY --from=base /app/main .
COPY --from=base /app/static ./static
EXPOSE 8080
CMD ["./main"]

# Use the standard Golang image for x86_64 (AMD64)
# FROM golang:1.22.5 AS base
# WORKDIR /app
# COPY go.mod .
# RUN go mod download
# RUN apt-get update && apt-get install -y gcc
# COPY . .
# # Build the binary for Linux and x86_64 (AMD64) architecture
# RUN GOOS=linux GOARCH=amd64 go build -o main .

# # Final stage with Distroless image
# FROM gcr.io/distroless/static
# COPY --from=base /app/main .
# COPY --from=base /app/static ./static
# EXPOSE 8080
# CMD ["./main"]
