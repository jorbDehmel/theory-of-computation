FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y pandoc graphviz texlive-science texlive-pictures make
WORKDIR /host
