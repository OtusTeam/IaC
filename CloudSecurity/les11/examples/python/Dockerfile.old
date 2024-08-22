# Use the stable Alpine image as the base image
FROM alpine:3.20

# Update the package index and install Python 3 and pip
RUN apk add --update-cache
RUN apk add python3
RUN apk add python3-dev
RUN apk add py-pip
RUN apk add build-base
#RUN pip install virtualenv 
# Clear cache
RUN rm -rf /var/cache/apk/*

# Copy the requirements.txt file to the /app directory
#COPY requirements.txt /app/

# Set the default working directory to /app
#WORKDIR /app

# Install the dependencies
#RUN pip3 install -r requirements.txt

# Copy the application code to the /app directory
# COPY hello.py /app/

# Set the default command to run when the container is started
CMD ["python3", "--version"]
#CMD ["python3", "hello.py"]
