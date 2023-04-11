# Hugo Docker Images

This project builds the extended version of hugo for a number of linux distributions for arm64 and amd64 architectures.

The images are found at the following locations:

 * [Docker Hub Repository](https://hub.docker.com/repository/docker/truemark/hugo/general)
 * [Amazon ECR Repository](https://gallery.ecr.aws/truemark/hugo)


Example Amazon ECR
```bash
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws
docker pull public.ecr.aws/truemark/hugo:latest
```

Example Docker Hub
```bash
docker login -u <<username>> -p <<password>> docker.io
docker pull docker.io/truemark/hugo:latest
```




