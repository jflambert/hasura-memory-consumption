# hasura-memory-consumption
Launch hasura, postgresql and preload test data with:

`docker-compose up -d`

This should take a few minutes to complete (31 million rows will be created)

Monitor memory usage with:

`docker stats --format "table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.MemUsage}}"`

Once postgres completes loading the data (CPU usage should go down to 0%), run the bash script in another terminal:

`./query_hasura.sh`

This script requests 1.5 million rows every 5 seconds. You can start multiple instances of the script to accelerate the test. Results show that Hasura will climb to 4GB of RAM consumption while Postgres remains at less than 1GB.
