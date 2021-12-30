FROM ruby:3.0.2
WORKDIR /code
COPY . /code
RUN bundle install --without development test
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn
RUN yarn install --production
RUN rake webpacker:compile
RUN rm -rf node_modules tmp/cache vendor/assets spec
CMD rails s -b 0.0.0.0 -p 80 -e production