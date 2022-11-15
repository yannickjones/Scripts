Select-AzSubscription -SubscriptionName "SUBSCRIPTION_NAME"

New-AzResourceGroupDeployment `
  -Name "InfraDeployment" `
  -ResourceGroupName "RG_NAME" `
  -TemplateFile ".\azuredeploy.json" `
  -TemplateParameterFile ".\azuredeploy.parameters.json"
