import base64
import io
import json
import os

import azure.functions as func
import pdf2image


def main(req: func.HttpRequest) -> func.HttpResponse:
    """Takes a dictionary containing a pdf file as base64
    :return: A dictionary containing a list of images as base64
    """

    try:
        images = pdf2image.convert_from_bytes(
            base64.b64decode(req.form.get("pdf_file")),
            poppler_path=os.path.join(
                os.path.dirname(os.path.abspath(__file__)), "poppler_binaries/"
            ),
        )

        return_dict = {"images": []}

        for img in images:
            imgArr = io.BytesIO()
            img.save(imgArr, format="jpeg")
            return_dict["images"].append(
                base64.b64encode(imgArr.getvalue()).decode("ascii")
            )

        return func.HttpResponse(json.dumps(return_dict))
    except Exception as ex:
        return func.HttpResponse(
            json.dumps({"status_code": 400, "error_message": str(ex)})
        )
