$subName = ""
$adminGroup = ""
$devGroup = ""
$readerGroup = ""
$rgName = ""

Select-AzSubscription -SubscriptionName $subName

Get-AzADGroup -SearchString $readerGroup
$readerGroupId = (Get-AzADGroup -DisplayName $readerGroup).id
New-AzRoleAssignment -ObjectId $readerGroupId `
-RoleDefinitionName "COMPANYReader" `
-ResourceGroupName $rgName

Get-AzADGroup -SearchString $devGroup
$devGroupId = (Get-AzADGroup -DisplayName $devGroup).id 
New-AzRoleAssignment -ObjectId $devGroupId `
-RoleDefinitionName "COMPANYSoftwareEng" `
-ResourceGroupName $rgName

Get-AzADGroup -SearchString $adminGroup
$adminGroupId = (Get-AzADGroup -DisplayName $adminGroup).id 
New-AzRoleAssignment -ObjectId $adminGroupId `
-RoleDefinitionName "COMPANYDevOpsEng" `
-ResourceGroupName $rgName

