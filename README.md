# Central-NAT-TGW
Central-NAT-TGW

Component:
1 TGW
2 VPC
1 NAT GW
1 IGW

Subnet:
VPC1 - 2 subnet - public and Tgw-att subnet
VPC2 - 2 subnet - Private subnet and TGW- Att subnet

VPC2 - Default route to TGW
TGW - Routing table with VPC1 and VPC2 propogated and static default route to VPC1 Att subnet
VPC1 - Att subnet woth Default route to NAT gateway, Public subnet having reverse route for VPC2 towards VPC2-Att subnet

