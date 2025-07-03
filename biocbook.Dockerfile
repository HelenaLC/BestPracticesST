ARG BRANCH
ARG OWNER
FROM ghcr.io/${OWNER}/deps:${BRANCH} AS builder
COPY . /opt/pkg
WORKDIR /opt/pkg

# Install book package and build book
RUN Rscript -e 'BiocManager::install("SummarizedExperiment", dependencies = TRUE, type = "source", force = TRUE)' && R CMD INSTALL . && \
    quarto install --quiet tinytex && \
    R CMD build --keep-empty-dirs --no-resave-data --no-manual .
