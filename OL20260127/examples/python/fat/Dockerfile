# Use the stable Alpine image as the base image
FROM alpine:3.20

# Update the package index and install Python 3 and pip
RUN apk add --update-cache
RUN apk add python3
RUN apk add python3-dev
RUN apk add py-pip
RUN apk add build-base
# Clear cache
RUN rm -rf /var/cache/apk/*

# Set the default command to run when the container is started
CMD ["python3", "--version"]
