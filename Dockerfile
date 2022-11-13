FROM bioconductor/bioconductor_docker:RELEASE_3_16

COPY --chown=rstudio:rstudio . /home/rstudio/

RUN sh /home/rstudio/docker/install_me.sh
RUN echo "RETICULATE_PYTHON_ENV=/opt/venv/anndata" >> "${R_HOME}/etc/Renviron.site"

RUN Rscript /home/rstudio/docker/install_me.R

