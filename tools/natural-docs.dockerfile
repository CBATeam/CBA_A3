FROM debian:latest

RUN apt update

RUN apt install wget unzip perl -y

RUN wget https://sourceforge.net/projects/naturaldocs/files/Stable%20Releases/1.52/NaturalDocs-1.52.zip/download -O /NaturalDocs.zip

RUN unzip NaturalDocs.zip -d NaturalDocs

RUN rm NaturalDocs.zip

RUN chmod +x /NaturalDocs/NaturalDocs

ENV PATH=/NaturalDocs:$PATH

CMD ["/bin/bash"]