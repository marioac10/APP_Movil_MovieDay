import json
import boto3
from botocore.exceptions import ClientError

#client = boto3.resource("dynamodb")
table = boto3.resource("dynamodb").Table("Test")
data = []

def lambda_handler(event, context):
    # TODO implement
    http_method = event['httpMethod']
    parameter = event['pathParameters']
    try:
        #global data
        if http_method == 'GET' and parameter == None:     #GET
            data = table.scan()['Items']
        elif http_method == 'POST':                        #POST
            body = json.loads(event['body'])
            #data = []
            id = body['id']
            brand = body['brand']
            model = body['model']
            generation = body['generation']
            serie = body['serie']
            modification = body['modification']
            response = table.put_item(
                Item = {
                    'id' : id,
                    'brand' : brand,
                    'model' : model,
                    'generation' : generation,
                    'serie' : serie,
                    'modification' : modification
                }
            )
            data = response
        elif http_method == 'PUT':                          #PUT
            body = json.loads(event['body'])
            id = body['id']
            brand = body['brand']
            model = body['model']
            generation = body['generation']
            serie = body['serie']
            modification = body['modification']
            response = table.update_item(
                Key = {
                    'id' : id
                },
                AttributeUpdates = {
                    'brand' : {
                        'Value' : brand,
                        'Action' : 'PUT'
                    },
                    'model' : {
                        'Value' : model,
                        'Action' : 'PUT'
                    },
                    'generation' : {
                        'Value' : generation,
                        'Action' : 'PUT'
                    },
                    'serie' : {
                        'Value' : serie,
                        'Action' : 'PUT'
                    },
                    'modification' : {
                        'Value' : modification,
                        'Action' : 'PUT'
                    }
                }
            )
            data = response
        elif http_method == 'DELETE':                       #DELETE
            #parameter = event['pathParameters']
            id = parameter['id']
            response = table.delete_item(
                Key = {
                    'id' : id
                }
            )
            data = response
        else:                                               #GET /{id}
            #parameter = event['pathParameters']
            id = parameter['id']
            response = table.get_item(
                Key = {
                    'id' : id
                }
            )
            data = response['Item']
            
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
