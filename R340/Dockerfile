FROM vjbaskar/ubuntu_base:18.04
ENV RBASE R-3.4.0

RUN apt-get -y install default-jre openjdk-11-jre-headless autoconf libmariadbclient-dev libmariadb-client-lgpl-dev

# COPY FILES

COPY ./${RBASE}.tar.gz /soft/${RBASE}.tar.gz
RUN mkdir -p /soft 
WORKDIR /soft/
RUN tar -zxvf ${RBASE}.tar.gz
WORKDIR /soft/${RBASE}
RUN ./configure --with-x=no && make -j 8 && make install

COPY src/install.R /soft/install.R
RUN Rscript /soft/install.R
