FROM archlinux:latest

RUN pacman -Syu --noconfirm

COPY . .

RUN zsh ./install.sh
