import os
import boto3
import json
import random
from datetime import datetime

s3 = boto3.client("s3")

def lambda_handler(event, context):
    """Writes the data to a date-encoded S3 folder.

    The folder structure should make it easy to locate rates from a given date and time.

    Args:
        event: dictionary in the same format as the output from the transform function
        context: supplied by AWS

    Returns:
        dictionary, either {'result': 'Success'} if successful or {'result': 'Failure'} otherwise
    """
    BUCKET_NAME = os.environ['BUCKET_NAME']
    
    now = datetime.now()
    tmp_file_path = "/tmp/json_data.json"
    date_str = now.strftime("%Y-%m-%d")
    time_str = now.strftime("%H-%M-%S")
    s3_key = f"{date_str}/{time_str}.json"

    try:
        with open(tmp_file_path, "w") as file:
            json.dump(event, file)
        with open(tmp_file_path, "r") as file:
            s3.upload_file(Bucket=BUCKET_NAME, Key=s3_key, Filename=tmp_file_path)

        return {"result": "Success"}
    except Exception as e:
        return {"result": "Failure", "error": str(e)}
