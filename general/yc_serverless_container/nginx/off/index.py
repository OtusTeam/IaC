import os
from sanic import Sanic
from sanic.response import text

app = Sanic(__name__)

@app.after_server_start
async def after_server_start(app, loop):
    print(f"App listening at port {os.environ['PORT']}")

@app.route("/hello")
async def hello(request):
    ip = request.headers["X-Forwarded-For"]
    print(f"Request from {ip}")
    return text("Hello!")

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=int(os.environ['PORT']), motd=False, access_log=False)
