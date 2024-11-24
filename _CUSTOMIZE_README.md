
# Overview of the customization

This project changes the definition of model list, so it can be used in eu-central-1 region and leverage inference profiles where needed.

Readme provides a step-by-step guide to create an image for the customized bedrock gateway.

## Changes made

The changes mostly relate to `src\api\bedrock.py` file where model list is defined.

## Building docket image

Note: arm64 params should be explicitly stated when building on Windows machine.

```bash
cd src

docker build --progress=plain --platform linux/arm64 -t customized-bedrock-gateway .
```

The resulting docker image should be uploaded into ECR and, then, used in AWS Lambda proxy function.
