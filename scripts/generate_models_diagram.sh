#!/bin/bash

# Generate models documentation for the network app

python manage.py graph_models network -o kablo_network_models.png
