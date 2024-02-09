FROM anibali/pytorch:1.13.0-cuda11.8
USER root

WORKDIR /src

RUN sudo apt-get update
RUN sudo apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN sudo apt-get --allow-releaseinfo-change update && \
    sudo apt-get install -y --no-install-recommends \
    curl \
    sudo \
    vim

ENV AWS_ACCESS_KEY_ID="LO706Y14ONG5GV2ODDL5"
ENV AWS_SECRET_ACCESS_KEY="vl1ZdYNciDBJSs0eICuW5HZZLKV1hMVc4GMGDIdr"

COPY . .

RUN pip install -e .
RUN pip install anndata matplotlib scanpy pandas 
