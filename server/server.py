from flask import Flask
from flask import Response
from flask import request
app = Flask(__name__)


@app.route("/", methods=["POST"])
def echo():
    '''
    Receive request.
    Read request body and return as is
    :return:
    '''
    if request.data:
        res = request.data.decode("UTF-8")
    else:
        return Response(response="You should send something data", status=400)
    return Response(response=res, status=200, headers={"content-type":request.content_type})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)