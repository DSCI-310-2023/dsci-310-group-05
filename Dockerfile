FROM rocker/rstudio:4.1.3

RUN Rscript -e "install.packages('remotes')"
RUN Rscript -e "remotes::install_version('tidyverse')"
RUN Rscript -e "remotes::install_version('tidymodels')"
RUN Rscript -e "remotes::install_version('repr')"
RUN Rscript -e "remotes::install_version('dplyr')"
RUN Rscript -e "remotes::install_version('tidyr')"
