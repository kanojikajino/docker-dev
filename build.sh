#!/bin/bash

image_name="dev-base"
docker build --ssh default -t $image_name .
docker tag $image_name:latest kanojikajino/$image_name:`date +"%Y%m%d"`
docker push kanojikajino/dev-base:`date +"%Y%m%d"`

