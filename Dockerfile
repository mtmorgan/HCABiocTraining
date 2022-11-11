FROM bioconductor/bioconductor_docker:RELEASE_3_16

## install packages etc as 'rstudio' user
USER rstudio
WORKDIR /home/rstudio

COPY --chown=rstudio:rstudio . /home/rstudio/src/HCABiocTraining

RUN echo "RETICULATE_PYTHON_ENV=/home/rstudio/.virtualenvs/r-reticulate" >> "/home/rstudio/.Renviron"

RUN Rscript /home/rstudio/src/HCABiocTraining/install.R

USER root
