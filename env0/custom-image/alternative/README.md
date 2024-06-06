# building custom docker images

usage:

```
BASE_TAG=3.0.770; USER_ID=100121001; docker buildx b --platform linux/amd64 --build-arg USER_ID=$USER_ID --build-arg BASE_TAG=$BASE_TAG -t away168/deployment-agent:$BASE_TAG-$USER_ID .
```
