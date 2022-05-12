# ruby-runner

### Run bundle locally
* `bundle`

## Wither docker-compose
### Build the container:
* `docker-compose build`

### Run the container:
* `docker-compose up && docker-compose rm -fsv`
  * This runs the container once and then removes it.

## Without docker-compose:
### Build the container:
* `docker build -t ruby_runner .`

### Run the container:
* `docker run -it --rm --env-file ./.env --mount type=bind,source="$(pwd)"/,target=/app ruby_runner [path to ruby file]`

## Connect to SQLite DB:
* `sqlite3 database.db`

### Show Databases:
* `.databases`

### Show Tables:
* `.tables`

### Describe Table:
* `pragma table_info(table_name)`

### Exit Sqlite Command Prompt:
* `.quit`

### Run a Program:
* `./run_program.sh my_program.rb`

### Run a Script:
* `./run_script.sh my_script.rb`