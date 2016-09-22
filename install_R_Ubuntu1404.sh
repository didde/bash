#!/bin/bash
echo “>>>>> Script for installing the statistical computation application R on a 64-bit Ubuntu 14.04 operating system”
echo “>>>>> APT is the Advanced Packaging Tool that downloads the R package. To get the most recent version of R, the correct source has to be added to the list of sources.”
sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list
echo
echo “>>>>> The Ubuntu archives on CRAN downloaded using APT are signed with a public key with ID E084DAB9. We’re adding this key our system.”
sudo gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
echo “>>>>> The key is added to APT”
gpg -a --export E084DAB9 | sudo apt-key add -
echo “>>>>> Updating the list of available packages since we updated the sources list.”
sudo apt-get update
echo “>>>>> Installing R”
sudo apt-get -y install r-base
echo “>>>>> Downloading Shiny via R, for global users“
sudo su - -c "R -e \"install.packages('shiny', repos = 'http://cran.rstudio.com/')\””
echo
echo “>>>>> To install R packages from GitHub, we need to use the devtools R package. The devtools R package requires three system packages"
sudo apt-get -y install libcurl4-gnutls-dev libxml2-dev libssl-dev
echo
echo “>>>>> Install devtools R package for global users" 
sudo su - -c "R -e \"install.packages('devtools', repos='http://cran.rstudio.com/')\""
echo
echo ">>>>> Installing packages: reshape, ggplot2, scales, Quandl"
echo
sudo apt-get -y install r-cran-ggplot2
sudo apt-get -y install r-cran-plyr
sudo apt-get -y install r-cran-reshape
sudo apt-get -y install r-cran-scales
sudo su - -c "R -e \"install.packages('Quandl', repos='http://cran.rstudio.com/')\””
echo
echo ">>>>> The GDebi tool is required to install the Shiny server" 
sudo apt-get -y install gdebi-core 
echo 
echo ">>>>> Downloading the Shiny Server version 1.3.0.403" 
wget -O shiny-server.deb http://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.3.0.403-amd64.deb 
echo 
echo ">>>>> GDebi installs the file that was downloaded." 
sudo gdebi shiny-server.deb 
echo 
echo ">>>>> The shiny server is now running, listening on port 3838."
