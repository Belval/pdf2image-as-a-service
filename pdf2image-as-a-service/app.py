import pdf2image
import zipfile

from io import BytesIO
from flask import Flask, request, redirect, abort, send_file

app = Flask(__name__, static_url_path='')

@app.route('/')
def index():
    return """<html><head></head><body><form action="/convert" method="post" enctype="multipart/form-data"><input type="file" name="file" id="file"><input type="submit" value="Upload Image" name="submit"></form></body></html>"""

@app.route('/convert', methods = ['GET', 'POST'])
def convert():
    if request.method == 'POST':
        if 'file' not in request.files:
            print(request.files)
            return redirect('/')
        file = request.files['file']
        if file.filename == '':
            return abort(400)
        if file:
            images = pdf2image.convert_from_bytes(file)
            zip_file_bytes = io.BytesIO()
            zip_file_to_return = zipfile.ZipFile(zip_file_bytes)
            for i, im in enumerate(images):
                im_bytesio = io.BytesIO()
                im.save(im_bytesio, format='JPEG')
                zip_file_to_return.writestr(i + '.jpg', im_bytesio.getvalue())
            return send_file(zip_file_to_return, attachement_filename='images.zip')
        else:
            return abort(500)
    else:
        return abort(404)

app.run(debug=True)