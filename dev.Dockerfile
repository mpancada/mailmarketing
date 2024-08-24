# TO BUILD
# sudo docker build --build-arg USERNAME=$(whoami) --build-arg RAILS_V=7.2 -t mailmarketing -f dev.Dockerfile .

ARG RUBY_V=3.3.4
FROM ruby:${RUBY_V}-slim

# Its important to create a user with the same name as your WSL so you dont have permissions problems related to files
ARG USERNAME
ARG RAILS_V

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libvips pkg-config curl unzip \
    vim

# install gem pg dependencies
RUN apt-get install libpq5 libpq-dev

RUN useradd ${USERNAME} --create-home --shell /bin/bash

RUN mkdir /rails_app
RUN chown -R ${USERNAME}:${USERNAME} /rails_app

USER ${USERNAME}:${USERNAME}

# Javascript run time
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/home/${USERNAME}/.bun/bin:$PATH"

WORKDIR /rails_app

# save the bundled gems locally on the project directory
# Dont forget to .gitignore this folder
ENV BUNDLE_PATH="./_bundle"

# by default documentation is not installed
RUN gem install 'bundler' \
    "rails:${RAILS_V}"

CMD ["/bin/bash"]
