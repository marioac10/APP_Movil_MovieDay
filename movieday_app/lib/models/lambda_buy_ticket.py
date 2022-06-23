import json
import boto3
from boto3.dynamodb.conditions import Key
from botocore.exceptions import ClientError

#client = boto3.resource("dynamodb")
table = boto3.resource("dynamodb").Table("TableCompraBoletosAc")
data = []
def lambda_handler(event, context):
    # TODO implement
    http_method = event['httpMethod']
    path = event['path']
    try:
        if http_method == 'POST':                        #POST
            body = json.loads(event['body'])
            username = body['username']
            claveTicket = body['claveTicket']
            idpelicula = body['id_pelicula']
            numboletos = body['numero_boletos']
            fecha = body['fecha']
            listaAsientos = body['lista_asientos']
            total = body['total']
            response = table.put_item(
                Item = {
                    'username' : username,
                    'clave': claveTicket
                    'id_pelicula' : idpelicula,
                    'numero_boletos' : numboletos,
                    'fecha' : fecha,
                    'lista_asientos' : listaAsientos,
                    'total' : total
                }
            )
            data = response
        elif http_method == 'GET':
            if path =='/compras/username': #si va a buscar uno en especifico
                id = event['queryStringParameters']['byusername']
                response = table.query(KeyConditionExpression=Key('username').eq(id))
                data = response['Items']
            else:
                data = table.scan()['Items']
            

            
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