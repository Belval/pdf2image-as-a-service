#
# lambda.sh
#

# Build poppler
./build_poppler.sh

# Creating the package
mkdir package
pip install Pillow --target package/
pip install pdf2image --target package/

# Moving the poppler libraries in the package
cp poppler_binaries/ package/

# Moving the function in the package
cp function.py package/

# Zipping the package
zip -r9 function.zip package/

# Creating AWS function
# For reference, see: https://docs.aws.amazon.com/cli/latest/reference/lambda/create-function.html
aws lambda create-function --function-name pdf2image-demo-function \
                           --runtime python3.6 \
                           --handler convert \
                           --description "Convert a PDF file to multiple images" \
                           --timeout 30 \
                           --publish \
                           --zip-file fileb://function.zip

