FROM vjbaskar/rbase:3.4.0

ENV DEEPSNVBASE deepSNV_1.24.0


# Package install
COPY src/install.R /run/install.R
RUN Rscript /run/install.R
RUN mkdir -p /project/sw_outpt/
WORKDIR /soft/

# Install deepsnv
COPY deepSNV_1.24.0.tar.gz /soft/deepSNV_1.24.0.tar.gz
COPY ./${DEEPSNVBASE}.tar.gz /soft/${DEEPSNVBASE}.tar.gz
RUN R CMD INSTALL /soft/${DEEPSNVBASE}.tar.gz

# Run deepsnv
COPY src/sw.R /run/sw.R
ENTRYPOINT ["Rscript", "/run/sw.R"]
