import sys
import getopt
import json
import boto3
from botocore.exceptions import NoCredentialsError

ACCESS_KEY='access'
SECRET_KEY='secret'
state=None
recording_file=None
keys_aws=""

test_local_file='/Users/atureci/Documents/ITU/SWE690_CapstoneProject/JitsiCodeBase/automation/jitsi/setup_jitsi_debian.sh'
bucket_name='itu-capstone-jitsi'

def upload_to_aws(local_file, bucket, object_name=None):
    s3=boto3.client('s3', aws_access_key_id=ACCESS_KEY,
                            aws_secret_access_key=SECRET_KEY)

    try:
        """
        :param file_name: File to upload
        :param bucket: Bucket to upload to
        :param object_name: S3 object name. If not specified then file_name is used
        :return: True if file was uploaded, else False
        """
        # If S3 object_name was not specified, use file_name
        if object_name is None:
            object_name = local_file

        s3.upload_file(local_file, bucket, object_name)
        print("Upload Successful")
        return True
    except FileNotFoundError:
        print("The file was not found")
        return False
    except NoCredentialsError:
        print("Credentials not available")
        return False

def load_aws_keys():
    global keys_aws
    global ACCESS_KEY
    global SECRET_KEY
    prod_file_location='/var/www/capstone/code/aws/aws_access.json'
    dev_file_location='/Users/atureci/Documents/ITU/SWE690_CapstoneProject/JitsiCodeBase/aws/aws_access.json'
    print("Printing state: ", state)
    #print("Printing Recording file: ", recording_file)
    if (state == "d"):
        with open(dev_file_location) as f:
            keys_aws = json.load(f)
            ACCESS_KEY=keys_aws['access_key']
            #print(ACCESS_KEY)
            SECRET_KEY=keys_aws['secret_key']
            #print(SECRET_KEY)
    else:
        with open(prod_file_location) as f:
            keys_aws = json.load(f)
            print(keys_aws)
            ACCESS_KEY=keys_aws['access_key']
            #print(ACCESS_KEY)
            SECRET_KEY=keys_aws['secret_key']
            #print(SECRET_KEY)


def main(argv):
    global state
    global recording_file
    try:
        opts, args = getopt.getopt(argv,"hs:f:",["state=","recording_file="])
    except getopt.GetoptError:
        print ('test.py -s <p:production, d:development> -f <recordingfile>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print ('test.py -s <inputfile> -f <outputfile>')
            sys.exit()
        elif opt in ("-s", "--state"):
            state = arg.lower()
        elif opt in ("-f", "--recording_file"):
            recording_file = arg
    print ('state is "', state)
    print ('Recording file is "', recording_file)

if __name__ == "__main__":
    main(sys.argv[1:])
    load_aws_keys()
    #print(ACCESS_KEY, " ", SECRET_KEY)
    uploaded = upload_to_aws(recording_file, bucket_name)


"""if len(sys.argv) > 1:
    state = str(sys.argv[1]).lower()
    #print("Printing state: ", state.lower())
    #print("Printing sys.argv[1].lower: ", sys.argv[1])

else:
    state = "p"

load_aws_keys()
print(ACCESS_KEY, " ", SECRET_KEY)
uploaded = upload_to_aws(local_file, bucket_name, state)
"""
