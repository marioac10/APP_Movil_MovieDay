import json
import boto3
from botocore.exceptions import ClientError

#client = boto3.resource("dynamodb")
table = boto3.resource("dynamodb").Table("TableUserAc")
data = []
def lambda_handler(event, context):
    # TODO implement
    http_method = event['httpMethod']
    parameter = event['queryStringParameters']
    try:
        if http_method == 'POST':                        #POST
            body = json.loads(event['body'])
            username = body['username']
            password = body['password']
            name = body['name']
            lastname = body['lastname']
            date_birth = body['date_birth']
            response = table.put_item(
                Item = {
                    'username' : username,
                    'password' : password,
                    'name' : name,
                    'lastname' : lastname,
                    'date_birth' : date_birth
                }
            )
            data = response
        elif http_method == 'PUT':                          #PUT
            body = json.loads(event['body'])
            username = body['username']
            password = body['password']
            name = body['name']
            lastname = body['lastname']
            date_birth = body['date_birth']

            response = table.update_item(
                Key = {
                    'username' : username
                },
                AttributeUpdates = {
                    'password' : {
                        'Value' : password,
                        'Action' : 'PUT'
                    },
                    'name' : {
                        'Value' : name,
                        'Action' : 'PUT'
                    },
                    'lastname' : {
                        'Value' : lastname,
                        'Action' : 'PUT'
                    },
                    'date_birth' : {
                        'Value' : date_birth,
                        'Action' : 'PUT'
                    }
                }
            )
            data = response
        elif http_method == 'DELETE':                       #DELETE
            #parameter = event['pathParameters']
            username = parameter['username']
            response = table.delete_item(
                Key = {
                    'username' : username
                }
            )
            data = response
            
    except ClientError as e:
        message="Unexpected error: %s" % e
        error= {
            'message':message,
            'statusCode': 500
        }
    
    return {
        'statusCode': 200,
        'body': json.dumps(data),
        'headers' : {
            'Message' : 'Application/json'
        }
    }