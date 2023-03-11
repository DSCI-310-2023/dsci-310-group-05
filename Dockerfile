FROM jupyter/r-notebook

RUN Rscript -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN Rscript -e "remotes::install_version('tidyverse', repos = 'https://cloud.r-project.org')"
RUN Rscript -e "remotes::install_version('tidymodels', repos = 'https://cloud.r-project.org')"
RUN Rscript -e "remotes::install_version('repr', repos = 'https://cloud.r-project.org')"
RUN Rscript -e "remotes::install_version('dplyr', repos = 'https://cloud.r-project.org')"
RUN Rscript -e "remotes::install_version('tidyr', repos = 'https://cloud.r-project.org')"
RUN Rscript -e "remotes::install_version('testthat', repos = 'https://cloud.r-project.org')"
RUN Rscript -e "remotes::install_version('ggplot2', repos = 'https://cloud.r-project.org')"
