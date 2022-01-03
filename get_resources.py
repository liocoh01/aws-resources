import boto3
import argparse

def get_all_resources(session):
    client = session.client('resourcegroupstaggingapi')
    out = client.get_resources()
    for resource in out['ResourceTagMappingList']:
        print(resource['Tags'], resource['ResourceARN'])

def describe_ec2_instances(session):
    client = session.client('ec2')
    instances = client.describe_instances()
    for instance in instances['Reservations']:
        print(instance)

def describe_rds_instances(session):
    client = session.client('rds')
    response = client.describe_db_instances()
    for i in response['DBInstances']:
        db_name = i['DBName']
        db_instance_name = i['DBInstanceIdentifier']
        db_type = i['DBInstanceClass']
        db_storage = i['AllocatedStorage']
        db_engine = i['Engine']
        print(db_instance_name,db_type,db_storage,db_engine)

session = boto3.Session(
    profile_name='liocoh01',
    region_name='us-east-1'
)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-o', "--opts")    
    args = parser.parse_args()
    opts = args.opts
    if opts == 'all':
        get_all_resources(session)
    if opts == 'ec2':
        describe_ec2_instances(session)
    if opts == 'rds':
        describe_rds_instances(session)


