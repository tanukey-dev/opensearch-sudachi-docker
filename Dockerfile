FROM opensearchproject/opensearch:2.17.1

ARG UID=1000
ARG GID=1000
ARG OPENSEARCH_HOME=/usr/share/opensearch

USER root
RUN yum install -y unzip wget

USER $UID
WORKDIR $OPENSEARCH_HOME

# プラグインをファイルからインストールする
RUN wget https://github.com/WorksApplications/elasticsearch-sudachi/releases/download/v3.2.3/opensearch-2.17.1-analysis-sudachi-3.2.3.zip
RUN /usr/share/opensearch/bin/opensearch-plugin install --batch file:opensearch-2.17.1-analysis-sudachi-3.2.3.zip

# 辞書をコピーする（core 版）
RUN wget https://github.com/WorksApplications/SudachiDict/releases/download/v20240716/sudachi-dictionary-20240716-core.zip
RUN unzip sudachi-dictionary-20240716-core.zip

RUN mkdir /usr/share/opensearch/config/sudachi
RUN cp sudachi-dictionary-20240716/system_core.dic /usr/share/opensearch/config/sudachi/system_core.dic