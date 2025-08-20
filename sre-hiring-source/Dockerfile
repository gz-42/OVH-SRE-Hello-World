# --- build stage---
FROM golang:1.23 AS build
WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o /sre-hiring ./main.go

# --- final stage ---
FROM scratch AS final
COPY --from=build /sre-hiring /sre-hiring

EXPOSE 8080

USER 4242

ENTRYPOINT ["/sre-hiring"]
