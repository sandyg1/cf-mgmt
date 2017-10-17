#!/bin/bash -e

mkdir ~/.ssh/ && touch ~/.ssh/known_hosts
ssh-keyscan github.com >>~/.ssh/known_hosts

export GOPATH=$PWD/go
export PATH=$GOPATH/bin:$PATH

go get github.com/Masterminds/glide
WORKING_DIR=$GOPATH/src/github.com/pivotalservices/cf-mgmt
mkdir -p ${WORKING_DIR}
cp -R source/* ${WORKING_DIR}/.
cd ${WORKING_DIR}
glide -v
glide install
go test $(glide nv) -v
