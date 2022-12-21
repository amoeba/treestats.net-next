FROM ruby:3.1.0

RUN apt update && apt install -y \
    build-essential \
    nodejs

WORKDIR /app
ADD . .

RUN bundle

EXPOSE 9292

CMD ["bundle", "exec", "rackup"]