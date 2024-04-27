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


To restrict RDP access only through an RDP gateway in AWS, you can follow these steps:

Set up an RDP Gateway: First, create an Amazon EC2 instance and configure it as an RDP Gateway. Ensure it's accessible from the internet.

Configure Security Group: In the security group associated with your RDP Gateway instance, allow inbound traffic on port 3389 (RDP) from your desired source IP addresses or ranges.

Configure Network Access Control Lists (ACLs): If necessary, set up network ACLs to control traffic at the subnet level. These can further restrict access to the RDP Gateway instance.

Disable RDP Access on Instances: Disable direct RDP access to your other instances by blocking inbound traffic on port 3389 in their security groups.

Route RDP Traffic through the Gateway: Update the routing table or VPN/firewall configuration to route RDP traffic through the RDP Gateway.

Test the Configuration: Ensure that RDP connections are only successful when initiated through the RDP Gateway and that direct connections are blocked.

By following these steps, you can restrict RDP access to your instances in AWS to only be accessible through the RDP Gateway.

