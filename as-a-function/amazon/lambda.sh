#
# lambda.sh
#

# Build poppler
#./build_poppler.sh

# Creating the package
mkdir -p package
pip3 install Pillow --target package/
pip3 install pdf2image --target package/

# Moving the poppler libraries in the package
cp -r poppler_binaries/ package/

# Moving the function in the package
cp amazon/function.py package/

# Zipping the package
zip -r9 function.zip package/

# Deleting package artifacts
rm -rf package/

# Creating AWS role
aws iam create-role --role-name pdf2image-demo-role --assume-role-policy-document AWSLambdaBasicExecutionRole

# Creating AWS function
# For reference, see: https://docs.aws.amazon.com/cli/latest/reference/lambda/create-function.html
aws lambda create-function --function-name pdf2image-demo-function \
                           --runtime python3.6 \
                           --handler convert \
                           --description "Convert a PDF file to multiple images" \
                           --timeout 30 \
                           --role pdf2image-demo-role \
                           --publish \
                           --zip-file fileb://function.zip
