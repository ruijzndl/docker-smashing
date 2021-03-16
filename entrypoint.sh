#!/bin/bash
set -e
if [[ "$SMASHING_KEY" != "" ]]
then
    (cd /; echo y|inject-secrets.sh)
fi
exec "$@"
