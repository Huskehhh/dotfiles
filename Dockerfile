FROM debian:latest

COPY . .

RUN apt update && apt upgrade -y
RUN apt install -y sudo zsh

RUN zsh install.sh
