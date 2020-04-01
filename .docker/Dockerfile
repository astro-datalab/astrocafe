# Copyright (C) Data Lab Team <datalab@noao.edu>
# Distributed under the terms of the BSD 3-Clause License.

ARG BASE_CONTAINER=jupyter/base-notebook:python-3.7.6
FROM $BASE_CONTAINER

LABEL maintainer="Data Lab Project <datalab@noao.edu>"

# enable Jupyter Lab
ENV JUPYTER_ENABLE_LAB='true'

USER root

## install SW from Ubuntu's package repository
#RUN apt-get update && apt-get install -y \
#    curl \
#    nodejs &&\
#    rm -rf /var/lib/apt/lists/*
    
# install stack
RUN apt-get update && apt-get install -y curl nodejs && \
    rm -rf /var/lib/apt/lists/* && \
    conda install -c astropy photutils pandas astroML -c conda-forge widgetsnbextension ipywidgets ipympl && \
    conda clean --all -f -y && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
    jupyter labextension install jupyter-matplotlib && \
    jupyter lab build && \
    jupyter lab clean && \
    npm cache clean --force && \
    /usr/local/bin/fix-permissions $HOME

    conda install -c astropy photutils pandas astroML && \
    conda install -c conda-forge widgetsnbextension ipywidgets ipympl && \

# switch back to normal user
USER jovyan
WORKDIR $HOME

# copy Jupyter config into file system 
COPY jupyter_notebook_config.json /opt/conda/etc/jupyter/jupyter_notebook_config.json

# fetch and unpack the notebooks
RUN curl -LJ https://github.com/noaodatalab/notebooks-latest/tarball/master | tar xz --wildcards --strip-components=2 */TeenAstronomyCafe -C ./

WORKDIR $HOME

# remove the default 'work' dir; we don't need it here
RUN rmdir $HOME/work/

# expose the public port we want to run on
EXPOSE 8888

ENTRYPOINT ["bash","/usr/local/bin/start-notebook.sh"]
