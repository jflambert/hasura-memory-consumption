# hasura-memory-consumption
An attempt to characterize [Hasura's memory consumption](https://github.com/hasura/graphql-engine/issues/4077) when providing very large results.

Launch hasura, postgresql and preload test data with:

`docker-compose up -d`

This should take a few minutes to complete (31 million rows will be created)

Monitor memory usage with:

`docker stats --format "table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.MemUsage}}"`

Once postgres completes loading the data (CPU usage should go down to 0%), run the bash script in another terminal:

`./query_hasura.sh`

This script requests 1.5 million rows every 5 seconds. You can start multiple instances of the script to accelerate the test. Results show that Hasura will climb between 4GB (1.2.2) and 8GB (1.3.0) of RAM consumption while Postgres mostly remains under 1GB.

After 12 hours, cancelling the script(s) will cause Postgres to go back down to ~100MB memory while Hasura remains at ~3GB.

This has been observed with Hasura 1.2.2 and 1.3.0-beta.4
