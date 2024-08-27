FROM python:3.10-slim

WORKDIR /app
RUN pip install --no-cache-dir --prefer-binary sanic
COPY ./index.py .

CMD [ "python", "index.py" ]
