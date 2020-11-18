# ruby-runner

## Wither docker-compose
### Build the container:
* `docker-compose build`

### Run the container:
* `docker-compose up && docker-compose rm -fsv`
  * This runs the container once and then removes it


## Without docker-compose:
### Build the container:
docker build -t ruby_runner .

### Run the container:
* `docker run -it --rm --env-file ./.env --mount type=bind,source="$(pwd)"/,target=/app ruby_runner run.rb`