FROM debian

RUN apt update 
RUN apt-get install -y git curl wget
RUN apt-get install -y apt-transport-https ca-certificates curl software-properties-common
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Bogota
RUN apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt install --yes autoconf automake libtool curl make g++ unzip \
    protobuf-c-compiler protobuf-compiler protobuf-compiler-grpc \
    cmake build-essential autoconf libtool pkg-config

RUN mkdir /temp
RUN mkdir /temp/buf-gen
WORKDIR /temp

# Install Golang
RUN wget https://golang.org/dl/go1.16.5.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.5.linux-amd64.tar.gz

ENV GO_ROOT=/usr/local/go
ENV GO_PATH=$HOME/go
ENV GOBIN=$GOPATH/bin
ENV PATH=$PATH:/usr/local/go/bin
ENV GO111MODULE=on
RUN go get -u github.com/golang/protobuf/proto
RUN go get -u github.com/golang/protobuf/protoc-gen-go
RUN go get google.golang.org/grpc
RUN go get google.golang.org/protobuf/cmd/protoc-gen-go
RUN go get google.golang.org/grpc/cmd/protoc-gen-go-grpc
RUN go version

# install buf
RUN BIN="/usr/local/bin" && \
    VERSION="0.44.0" && \
    BINARY_NAME="buf" && \
    curl -sSL \
        "https://github.com/bufbuild/buf/releases/download/v${VERSION}/${BINARY_NAME}-$(uname -s)-$(uname -m)" \
        -o "${BIN}/${BINARY_NAME}" && \
    chmod +x "${BIN}/${BINARY_NAME}"

RUN buf --version

COPY generate-buf.sh .
