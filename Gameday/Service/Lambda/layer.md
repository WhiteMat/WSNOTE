# Source : https://repost.aws/knowledge-center/lambda-python-package-compatible

* Open a command prompt. Then, run the following pip command to confirm that you're using a version of pip that's version 19.3.0 or newer:
```bash
pip --version
```

* If you're using a version of pip that's older than pip version 19.3.0, then upgrade to the latest version of pip:
```bash
python3.9 -m pip install --upgrade pip
```

* Install the precompiled Python package's .whl file as a dependency in your Lambda function's project directory:

Important: Replace my-lambda-function with the name of your function's project directory.

```bash
pip install \    
    --platform manylinux2014_x86_64 \
    --target=my-lambda-function \
    --implementation cp \
    --python-version 3.9 \
    --only-binary=:all: --upgrade \
    pandas
```