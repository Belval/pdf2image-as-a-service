# [START gae_python37_app]
import base64
import json
import io

from flask import Flask, request
from pdf2image import convert_from_bytes

app = Flask(__name__)

@app.route('/ping')
def ping():
    return "pong"

@app.route('/', methods=['POST'])
def convert():
    images = convert_from_bytes(
        base64.b64decode(request.json['pdf_file']),
        poppler_path='poppler_binaries/')

    return_dict = {'images': []}

    for img in images:
        imgArr = io.BytesIO()
        img.save(imgArr, format='jpeg')
        return_dict['images'].append(
            base64.b64encode(imgArr.getvalue()).decode('ascii')
        )

    return json.dumps(return_dict)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8080, debug=True)
# [END gae_python37_app]
