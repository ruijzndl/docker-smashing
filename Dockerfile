FROM ruby:2.6

RUN apt-get update && \
    apt-get upgrade -yq && \
    apt-get install -yq nodejs fortune

RUN mkdir /smashing
WORKDIR /smashing
COPY Gemfile /smashing/Gemfile

RUN bundle install --jobs 80
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENV PATH=$PATH:/usr/games
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3030

CMD ["smashing", "start", "-p", "3030"]
