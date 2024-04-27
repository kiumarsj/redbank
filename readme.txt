import boto3

def enable_rdp_gateway(region_name, vpc_id, subnet_ids):
    client = boto3.client('ec2', region_name=region_name)
    response = client.create_vpc_endpoint(
        VpcEndpointType='Gateway',
        VpcId=vpc_id,
        ServiceName='com.amazonaws.' + region_name + '.ssm',
        SubnetIds=subnet_ids
    )
    print("RDP gateway enabled successfully.")
    return response['VpcEndpoint']['VpcEndpointId']

def disable_rdp_gateway(region_name, vpc_endpoint_id):
    client = boto3.client('ec2', region_name=region_name)
    response = client.delete_vpc_endpoints(
        VpcEndpointIds=[vpc_endpoint_id]
    )
    print("RDP gateway disabled successfully.")

# Example usage:
vpc_id = 'your_vpc_id'
subnet_ids = ['subnet_id_1', 'subnet_id_2']
region_name = 'your_region_name'

# Enable RDP gateway
vpc_endpoint_id = enable_rdp_gateway(region_name, vpc_id, subnet_ids)

# Disable RDP gateway
disable_rdp_gateway(region_name, vpc_endpoint_id)
