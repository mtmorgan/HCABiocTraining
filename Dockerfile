FROM bioconductor/bioconductor_docker:RELEASE_3_16

COPY --chown=rstudio:rstudio . /home/rstudio/HCABiocTraining

RUN sh /home/rstudio/HCABiocTraining/docker/install_me.sh
RUN Rscript /home/rstudio/HCABiocTraining/docker/install_me.R

RUN echo "RETICULATE_PYTHON_ENV=/opt/venv/anndata" >> "${R_HOME}/etc/Renviron.site"
