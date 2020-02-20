#!/usr/bin/env bash

az policy definition create \
    -n nsgrules \
    --rules @./Rule.json \
    --params @./parameters.json
