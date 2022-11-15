$subscriptionName = ""
$appgatewayName = ""
$rgName = ""

Select-AzSubscription -Current -SubscriptionName $subscriptionName

# Get Azure Application Gateway
$appgw=Get-AzApplicationGateway -Name $appgatewayName -ResourceGroupName $rgName 
 
# Stop the Azure Application Gateway
Stop-AzApplicationGateway -ApplicationGateway $appgw
 
# Start the Azure Application Gateway (optional)
Start-AzApplicationGateway -ApplicationGateway $appgw
