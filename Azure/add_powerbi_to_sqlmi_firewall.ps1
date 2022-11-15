#enter your subscription ID
Set-AzContext -SubscriptionId "XXX-XXX-XXX-XXX-XXX" 

#Provide the resource group for your Network Security Group
$RGname = ""
#Enter the port for the SQL Managed Instance Public Endpoint
$port = 3342
#name the NSG rule
$rulename = "allow_inbound_PowerBI"
#provide the name of the Network Security Group to add the rule to
$nsgname = ""
#set direction to inbound to allow PowerBI to access SQL MI
$direction = "Inbound"
#set the priority of the rule. Priority must be higher (ie. lower number) than the deny_all_inbound (4096)
$priority = 400
#set the service tags for the source to \u201cPowerBI\u201d
$serviceTag = "PowerBI"

#Set the protocol as TCP
$protocol = 'tcp'

# Get the NSG resource
$nsg = Get-AzNetworkSecurityGroup -Name $nsgname -ResourceGroupName $RGname

# Add the inbound security rule.
$nsg | Add-AzNetworkSecurityRuleConfig -Name $rulename -Description "Allow PowerBI Access to SQL MI for Direct Query or Data Refresh." -Access Allow `
    -Protocol $protocol -Direction $direction -Priority $priority -SourceAddressPrefix $serviceTag -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange $port

# Update the NSG.
$nsg | Set-AzNetworkSecurityGroup
