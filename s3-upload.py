# Usage:
#
# python3 s3-upload.py path/to/file-to-upload.tar.gz [path/on/s3]
#
# If path/on/s3 is provided, the resulting file will be path/on/s3/file-to-upload.tar.gz
# Otherwise, it will be path/to/file-to-upload.tar.gz
#
# Assumes AWS credentials are set outside of this
# (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY)
# and that that user has access to write to the BUCKET specified below

import os
import sys

import boto3

BUCKET = 'arrow-r-nightly'

if __name__ == '__main__':
    source_file = sys.argv[1]
    if len(sys.argv) > 2:
        dest_file = sys.argv[2] + "/" + os.path.basename(source_file)
    else:
        dest_file = source_file
    if dest_file[0] == "/"
        # Prune a leading slash, S3 doesn't handle this gracefully
        dest_file = destfile[1:]
    print("Uploading " + dest_file)
    with open(source_file, 'rb') as data:
        boto3.resource('s3').Bucket(BUCKET).put_object(Key=dest_file, Body=data)
    print("Done!")
