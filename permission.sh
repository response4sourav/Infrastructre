#!/usr/bin/env bash
set -e

if [ -f create-cluster.sh ]; then
    chmod +x create-cluster.sh
fi

if [ -f remove-cluster.sh ]; then
    chmod +x remove-cluster.sh
fi

if [ -f create-k8s.sh ]; then
    chmod +x create-k8s.sh
fi
