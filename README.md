# Docker Bulk Image Trim & Optimize
Docker container to trim white space and optimize a folder of images.

## Build
```
docker build -t r4wdev/images-trim-optimize:latest .
```

## Run
replace /files and /file-opt with your input and output folders
```
docker run --rm -v "$PWD/files":/app/input -v "$PWD/files-opt":/app/output -it r4wdev/images-trim-optimize:latest
```

## Run with custome image_optim config
Configuration options can be found [here](https://github.com/toy/image_optim#configuration).

First, create your .image_optim.yml file then mount and run with:
```
docker run --rm -v "$PWD/files":/app/input -v "$PWD/files-opt":/app/output -v "$PWD/.image_optim.yml":/app/.image_optim.yml -it r4wdev/images-trim-optimize:latest
```
