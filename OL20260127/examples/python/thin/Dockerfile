# Use the stable Alpine image as the base image
FROM alpine:3.20

# Update the package index and install Python 3 and pip
RUN apk cache clean \
&& apk update \
&& apk add python3 \
&& rm -rf /var/cache/apk/*

# Set the default command to run when the container is started
CMD ["python3", "--version"]
