# pandas-docker

Docker base image with pandas built on miniconda. Built on phusion/baseimage
which is Ubuntu as a well behaved Docker citizen.

This image uses miniconda to install a data science toolkit
consisting of:

- dateutil
- matplotlib
- numpy
- pandas
- pytables
- scipy

and good ole `pip`.

## Building

This package is available on docker.io.

[docker](http://www.docker.com) is require to build, test, and
release this package to docker.io.

### Mac usage quick start

After installing boot2docker do:

```
boot2docker up
$(boot2docker shellinit)
```

### Build

Build is about 10 minutes the first time. Much faster after that thanks
to docker caching.

`make build`

### Test

This runs the pandas test suite on the newly built image. It takes about
10 minutes.

`make test`

## Using

### Interactively

`docker run -it humu/pandas /bin/bash`

### As a base for your application

Create a Dockerfile based on this image and add your stuff.
