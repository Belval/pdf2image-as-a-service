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
            images = pdf2image.convert_from_bytes(file.read())
            zip_file_bytes = BytesIO()
            zip_file = zipfile.ZipFile(zip_file_bytes, 'w')
            for i, im in enumerate(images):
                im_bytesio = BytesIO()
                im.save(im_bytesio, format='JPEG')
                zip_file.writestr(str(i) + '.jpg', im_bytesio.getvalue())
            zip_file.close()
            zip_file_bytes.seek(0)
            return send_file(zip_file_bytes, as_attachment=True, attachment_filename='images.zip')
        else:
            return abort(500)
    else:
        return abort(404)

if __name__=='__main__':
    app.run(host="0.0.0.0")
