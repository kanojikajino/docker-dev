#!/bin/bash

image_name="dev-base"
docker build --progress=plain --ssh default --platform linux/amd64 -t $image_name . #--no-cache
docker tag $image_name:latest kanojikajino/$image_name:`date +"%Y%m%d"`
docker push kanojikajino/$image_name:`date +"%Y%m%d"`

