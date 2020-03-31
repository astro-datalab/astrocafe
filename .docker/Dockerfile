ARG BASE_CONTAINER=jupyter/base-notebook:python-3.7.6
FROM $BASE_CONTAINER

LABEL maintainer="Data Lab Project <datalab@noao.edu>"

ENV JUPYTER_ENABLE_LAB='true'

USER root

# install stack
RUN apt-get update && apt-get install -y curl nodejs
RUN conda install -c astropy photutils pandas astroML
RUN conda install -c conda-forge widgetsnbextension ipywidgets ipympl
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN jupyter labextension install jupyter-matplotlib

RUN /usr/local/bin/fix-permissions $HOME

USER jovyan
WORKDIR $HOME

COPY jupyter_notebook_config.json /opt/conda/etc/jupyter/jupyter_notebook_config.json

RUN curl -LJ https://github.com/noaodatalab/notebooks-latest/tarball/master | tar xz --wildcards --strip-components=2 */TeenAstronomyCafe -C ./

WORKDIR $HOME
RUN rmdir $HOME/work/

ENTRYPOINT ["bash","/usr/local/bin/start-notebook.sh"]
