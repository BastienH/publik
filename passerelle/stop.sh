
#!/bin/bash

# Fail on errors
set -eu

# Stop NGINX
service nginx stop

# Stop passerelle
service passerelle stop

# Stop HOBO Agent
service supervisor stop

# Pause 2 seconds
sleep 2