FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  curl \
  gpg \
  libyaml-dev

# Install Yarn using keyrings (modern Debian-compatible method)
RUN mkdir -p /usr/share/keyrings && \
  curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarn-archive-keyring.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian stable main" > /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -y yarn

# Create and set app directory
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# Precompile assets if needed (optional)
# RUN bundle exec rails assets:precompile

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
