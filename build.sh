#!/bin/bash

# Create the output `build` directory
mkdir -p build
# Perform a clean build of the project using docker
# (In some cases `stack clean` is not needed, you can try removing it)
stack clean --docker
stack build --docker

# Copy the generated executable to the output path
cp $(stack --docker path --local-install-root)/bin/bootstrap build

# Create a `function.zip` file to upload
cd build && zip function.zip bootstrap && rm bootstrap && cd ..
