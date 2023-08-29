FROM jupyter/base-notebook:lab-3.6.3
LABEL maintainer="Matt Wiese <matthew.wiese@cornell.edu>"
SHELL ["/bin/bash", "-c"]

# Install apt packages - for R packages built from source
USER root
RUN apt-get update  --yes &&                      \
    apt-get install --yes --no-install-recommends \
    git                                           \
    less                                          \
    vim                                           \
    nano                                          \
    build-essential                               \
    gfortran                                      \
    gcc                                           \
    libfontconfig1-dev                            \
    libfreetype6-dev                              \
    fonts-dejavu                                  \
    libfribidi-dev                                \
    libharfbuzz-dev                               \
    unixodbc                                      \
    unixodbc-dev                                  \
    make                                          \
    pandoc                                        \
    libicu-dev                                    \
    libjpeg-dev                                   \
    libpng-dev                                    \
    libtiff-dev                                   \
    zlib1g-dev                                    \
    libssl-dev                                    \
    libxml2-dev                                   \
    libcurl4-openssl-dev                          \
    libcairo2-dev                                 \
    libxt-dev                                     \
    libgeos-dev                                   \
    libudunits2-dev                               \
    libgdal-dev                                   \
    gdal-bin                                      \
    libproj-dev                                   \
    libsqlite3-dev                                \
    libudunits2-dev                               \
    && rm -rf /var/lib/apt/lists/*
USER ${NB_UID}

# Install Conda libraries from environment.yml into base environment
ADD environment.yml /tmp/environment.yml
RUN mamba env update --name base --file /tmp/environment.yml

# Install R libraries
ADD libraries.R /tmp/libraries.R
RUN Rscript /tmp/libraries.R

# Additional pip installs
# NOTE: JupyterHub package version must match deployed Hub version
# NOTE: Scheduler depends on Pydantic 1.x
RUN pip install --no-cache-dir jupyterhub==4.0.1 \
    jupyter_scheduler                            \
    pydantic==1.10

# Pull BrAPI Helper package from NAPB workshop file server and install it
RUN cd /tmp && wget https://demo.hub.maizegenetics.net/files/brapi_helper_installer.run && chmod +x brapi_helper_installer.run && ./brapi_helper_installer.run

# Pull Brandon's demo files
RUN cd /home/${NB_USER}                                                       && \
    wget https://demo.hub.maizegenetics.net/files/napb_2023_bgh_demo_01.ipynb && \
    wget https://demo.hub.maizegenetics.net/files/napb_2023_bgh_demo_02.ipynb && \
    wget https://demo.hub.maizegenetics.net/files/napb_demo_data.tar.gz       && \
    tar -xvf napb_demo_data.tar.gz                                            && \
    rm napb_demo_data.tar.gz

# ILCI Templates
RUN cd /tmp                                                                              && \
    git clone https://github.com/agostof/ILCI-NotebookTemplates                          && \
    mv ILCI-NotebookTemplates/src/templates/*_rTASSEL_*.ipynb /home/${NB_USER}/templates

# Install Kotlin 1.5 (for PHG)
RUN cd /tmp                                                                                       && \
    wget https://github.com/JetBrains/kotlin/releases/download/v1.5.32/kotlin-compiler-1.5.32.zip && \
    jar xvf kotlin-compiler-1.5.32.zip                                                            && \
    chmod +x kotlinc/bin/kotlin                                                                   && \
    chmod +x kotlinc/bin/kotlinc                                                                  && \
    mv kotlinc /home/${NB_USER}/.kotlinc                                                          && \
    echo "PATH=\$PATH:/home/${NB_USER}/.kotlinc/bin" >> /home/${NB_USER}/.profile

# Install faSize
RUN mkdir /home/${NB_USER}/.bin                                                                 && \
    wget -P /home/${NB_USER}/.bin https://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/faSize && \
    chmod +x /home/${NB_USER}/.bin/faSize                                                       && \
    echo "PATH=\$PATH:/home/${NB_USER}/.bin" >> /home/${NB_USER}/.profile

# Jupyter Notebook config
ADD jupyter_notebook_config.py /home/${NB_USER}/.jupyter/jupyter_notebook_config.py