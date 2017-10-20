FROM haskell:8

RUN mkdir /app
COPY ["./", "/app"]
WORKDIR /app
RUN apt-get update
RUN apt-get install make xz-utils
RUN stack setup
RUN stack build
CMD ["stack", "exec", "nameday-api", "./data/nameday.tsv", "80"]
