#!/bin/bash
docker run -it --rm --env-file ./.env --mount type=bind,source="$(pwd)"/,target=/app ruby_runner $1