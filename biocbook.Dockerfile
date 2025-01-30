ARG BIOC_VERSION
ARG OWNER
FROM ghcr.io/${OWNER}/deps:${BIOC_VERSION} AS builder
COPY . /opt/pkg
WORKDIR /opt/pkg

# Install book package and build book
RUN R CMD INSTALL . && \
    quarto install --quiet tinytex && \
    R CMD build --keep-empty-dirs --no-resave-data .