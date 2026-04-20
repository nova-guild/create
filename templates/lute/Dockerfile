FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl unzip ca-certificates libssl3 libdbus-1-3 libstdc++6 git && \
    rm -rf /var/lib/apt/lists/*

RUN curl -f -L "https://github.com/luau-lang/lute/releases/download/v1.0.0/lute-linux-x86_64.zip" -o lute.zip && \
    unzip -j lute.zip && \
    chmod +x lute && \
    mv lute /usr/local/bin/lute && \
    rm lute.zip

RUN curl -f -L "https://github.com/pesde-pkg/pesde/releases/download/v0.7.3+registry.0.2.3/pesde-0.7.3-linux-x86_64.zip" -o pesde.zip && \
    unzip -j pesde.zip && \
    chmod +x pesde && \
    mv pesde /usr/local/bin/pesde && \
    rm pesde.zip

WORKDIR /app

ENV PESDE_CONFIG_USER_TOKEN_STORE=file

COPY pesde.toml ./

RUN mkdir -p /root/.pesde && pesde install

COPY . .

EXPOSE 10000

CMD ["lute", "run", "start"]