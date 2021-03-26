# my-haskell-lambda

A few things that are good to know:

### The build.sh script does not manage to pull down the docker image

You can do this manually before running `build.sh`.

```
$ docker pull fpco/stack-build:lts-15.16
```

### Building locally does not work on OSX

The code won't build on OSX (and maybe other OSs) because the need of static linking.
If you want to build and test something locally, you can uncomment the linking
lines in `package.yaml`:

```
# ghc-options: -O2 -static -threaded
# cc-options: -static
# ld-options: -static -pthread
```

Note that this won't produce an executable that can be used as a lambda.