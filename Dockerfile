# Rubyバージョン指定
FROM ruby:3.1

# Node.jsのインストール
RUN curl -fsSL https://nodejs.org/dist/v16.13.0/node-v16.13.0-linux-arm64.tar.xz -o nodejs.tar.xz \
    && mkdir -p /usr/local/lib/nodejs \
    && tar -xJf nodejs.tar.xz -C /usr/local/lib/nodejs \
    && rm nodejs.tar.xz
ENV PATH="/usr/local/lib/nodejs/node-v16.13.0-linux-arm64/bin:${PATH}"

# Yarnのインストール
RUN curl -L https://github.com/yarnpkg/yarn/releases/download/v1.22.10/yarn-v1.22.10.tar.gz -o yarn.tar.gz \
    && mkdir -p /opt/yarn \
    && tar -xzf yarn.tar.gz -C /opt/yarn --strip-components=1 \
    && rm yarn.tar.gz
ENV PATH="/opt/yarn/bin:${PATH}"

# アプリケーションディレクトリの作成
WORKDIR /myapp

# GemfileとGemfile.lockをコピーしてbundle installを実行
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションコードのコピー
COPY . .

# コンテナ起動時に実行させるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# ポート3000を公開
EXPOSE 3000

# Railsサーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
