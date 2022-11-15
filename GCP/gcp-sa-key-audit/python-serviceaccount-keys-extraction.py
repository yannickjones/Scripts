# Python script to extract data on service account keys

import os, sys
from googleapiclient import discovery
from oauth2client.client import GoogleCredentials

# Get google credentials
credentials = GoogleCredentials.get_application_default()
service = discovery.build('iam', 'v1', credentials=credentials)

project = sys.argv[1]

# Transform data
data = sys.stdin.read()
data = data.replace("\n", ",")
data = data.split(",")

# Iterate through data
for sa in data:
    if sa != "":
        # Extract user managed keys
        ukeys = service.projects().serviceAccounts().keys().list(name='projects/' + project + '/serviceAccounts/' + sa, keyTypes="USER_MANAGED").execute()
        try:
            for ukey in ukeys["keys"]:
                keyname = ukey['name'].split("/")[-1]
                validFrom = ukey['validAfterTime']
                validUntil = ukey['validBeforeTime']        
                korigin = ukey['keyOrigin']
                ktype = ukey['keyType']
                print(f"{project},{sa},{keyname},{validFrom},{validUntil},{korigin},{ktype}")
        except:
            pass
        
        # Extract system managed keys
        skeys = service.projects().serviceAccounts().keys().list(name='projects/' + project + '/serviceAccounts/' + sa, keyTypes="SYSTEM_MANAGED").execute()
        try:
            for skey in skeys["keys"]:
                keyname = skey['name'].split("/")[-1]
                validFrom = skey['validAfterTime']
                validUntil = skey['validBeforeTime']        
                korigin = skey['keyOrigin']
                ktype = skey['keyType']
                print(f"{project},{sa},{keyname},{validFrom},{validUntil},{korigin},{ktype}")
        except:
            pass