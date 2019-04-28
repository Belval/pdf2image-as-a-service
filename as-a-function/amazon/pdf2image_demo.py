import base64
import io
import json

import pdf2image

def convert(event, context):
    """Takes a dictionary containing a pdffile as base64
    :return: A dictionary containing a list of images as base64
    """
    
    images = pdf2image.convert_from_bytes(
        base64.b64decode(event['pdf_file']),
        poppler_path='poppler_binaries/')

    return_dict = {'images': []}

    for img in images:
        imgArr = io.BytesIO()
        img.save(imgArr)
        return_dict['images'].append(
            base64.b64encode(imgArr.getvalue())
        )

    return json.dumps(return_dict)

