set -x
docker run -d --rm -p 127.0.0.1:80:80 -e PORT=80  hello
curl http://127.0.0.1
