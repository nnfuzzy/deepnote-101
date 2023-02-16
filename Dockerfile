# Specifies the Docker image from Python
FROM python:3.9-slim-bullseye

# Image descriptions
LABEL maintainer="mining.facts@gmail.com"
LABEL version="0.1"
LABEL description = "data science environment base"

# Specifies the working directory
WORKDIR /data

# Add g++
RUN echo 'deb http://deb.debian.org/debian testing main' >> /etc/apt/sources.list \
    && apt-get update && apt-get install -y --no-install-recommends -o APT::Immediate-Configure=false gcc g++

# Installs the Python data science libraries
RUN pip install nbterm==0.0.13 ipython==8.9.0 numpy==1.24.1 matplotlib==3.6.3 seaborn==0.12.2 pandas==1.5.3 scikit-learn==1.2 pymc==5.0.2