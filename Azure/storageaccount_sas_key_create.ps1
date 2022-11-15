$ctx = New-AzStorageContext -StorageAccountName "storageaccount" -StorageAccountKey "xxxxxxxxxx=="
$StartTime = Get-Date
$EndTime = $startTime.AddDays(365)
New-AzStorageContainerSASToken -Context $ctx `
    -Name "folder/Location" `
    -Permission racwdl `
    -StartTime $startTime `
    -ExpiryTime $endTime `
    -IPAddressOrRange 8.8.8.8