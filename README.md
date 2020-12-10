# Docker Bulk Image Trim & Optimise
Docker container to trim white space and optimise a folder of images.

## Build
```
docker build -t r4wdev/images-trim-optimise:latest .
```

## Run
replace /files and /file-opt with your input and output folders
```
docker run --rm -v "$PWD/files":/app/input -v "$PWD/files-opt":/app/output -it r4wdev/images-trim-optimise:latest
```
