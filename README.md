# Yocto Building Environment

This repo creates a reproducible environment to create your OpenEmbedded based projects. <br />
It leverages the containerization provided by Docker to isolate the building environment from your host.

To start, just clone the repo and run:

    cd yocto-build-env
    ./start
    
The container starts, and you get to the building environment shell.
Once there you may issue:

    /buildenv > init-env workspace build

You are now the OpenEmbedded environment with some convenient local.conf already set for you.
