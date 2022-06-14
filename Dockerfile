from ubuntu:latest 

COPY . .

RUN apt update && apt upgrade -y
RUN apt install -y sudo

RUN bash install.sh
