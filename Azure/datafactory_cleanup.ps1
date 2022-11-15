$dataFactoryName="datafactory-name"
$resourceGroupName= "resource-group-name"

param([string] $dataFactoryName, [string]$resourceGroupName)

    Write-Output "Data factory  : $dataFactoryName"
    Write-Output "Resource group: $resourceGroupName"
    Write-Output "========================================"

    Write-Output "Collecting resource locks"
    $locks = Get-AzResourceLock -ResourceName $dataFactoryName -ResourceType "Microsoft.DataFactory/factories" -ResourceGroupName $resourceGroupName
    # Set-AzResourceLock -LockLevel CanNotDelete -ResourceName $dataFactoryName -ResourceType "Microsoft.DataFactory/factories" -ResourceGroupName $resourceGroupName
    Write-Output "Found $($locks.Count) locks"
    $locks | ForEach-Object -process {
        Write-Output "Removing Lock Id: $($lock.LockId)"
        Remove-AzResourceLock -LockId $_.LockId -Force
    }

    Write-Output "Collecting triggers"
    $triggers = Get-AzDataFactoryV2Trigger -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName

    Write-Output "Found $($triggers.Count) triggers"
    $triggers | ForEach-Object -process { 
        Write-Output "Stopping trigger $($_.name)"
        Stop-AzDataFactoryV2Trigger -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
        Write-Output "Deleting trigger $($_.name)"
        Remove-AzDataFactoryV2Trigger -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
    }

    Write-Output "========================================" 
    Write-Output "Collecting pipelines"
    $pipelines = Get-AzDataFactoryV2Pipeline -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName | Sort-Object -Property name -Descending
    Write-Output "Found $($pipelines.Count) pipelines"
    $pipelines | ForEach-Object -process { 
        Write-Output "Deleting pipeline $($_.name)"
        Remove-AzDataFactoryV2Pipeline -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
    }

    Write-Output "========================================" 
    Write-Output "Collecting dataflows"
    $dataFlows = Get-AzDataFactoryV2DataFlow -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName

    Write-Output "Found $($dataFlows.Count) data flows"
    $dataFlows | ForEach-Object -process {
        Write-Output "Removing DataFlow $($_.name)"
        Remove-AzDataFactoryV2DataFlow -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
    }

    Write-Output "========================================"
    Write-Output "Collecting datasets"
    $datasets = Get-AzDataFactoryV2Dataset -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName
    Write-Output "Found $($datasets.Count) datasets"
    $datasets | ForEach-Object -process { 
        Write-Output "Deleting dataset $($_.name)"
        Remove-AzDataFactoryV2Dataset -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
    }
    Write-Output "========================================"
    Write-Output "Collecting Linked services"
    $lservices = Get-AzDataFactoryV2LinkedService -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName | Sort-Object -Property name -Descending
    Write-Output "Found $($lservices.Count) linked services"

    $lservices | ForEach-Object -process { 
        Write-Output "Deleting linked service $($_.name)"
        Remove-AzDataFactoryV2LinkedService -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
    }

#    Write-Output "========================================"
#    Write-Output "Collecting Integration runtimes "
#    $runtimes = Get-AzDataFactoryV2IntegrationRuntime -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName
#    Write-Output "Found $($runtimes.Count) Integration Runtimes"
#    $runtimes | ForEach-Object -process { 
#        Write-Output "Deleting Integration runtime $($_.name)"
#        Remove-AzDataFactoryV2IntegrationRuntime -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
#    }
    Write-Output "Collecting triggers"
    $triggers = Get-AzDataFactoryV2Trigger -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName

    Write-Output "Found $($triggers.Count) triggers"
    $triggers | ForEach-Object -process { 
        Write-Output "Stopping trigger $($_.name)"
        Stop-AzDataFactoryV2Trigger -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
        Write-Output "Deleting trigger $($_.name)"
        Remove-AzDataFactoryV2Trigger -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
    }

    Write-Output "========================================" 
    Write-Output "Collecting pipelines"
    $pipelines = Get-AzDataFactoryV2Pipeline -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName | Sort-Object -Property name -Descending
    Write-Output "Found $($pipelines.Count) pipelines"
    $pipelines | ForEach-Object -process { 
        Write-Output "Deleting pipeline $($_.name)"
        Remove-AzDataFactoryV2Pipeline -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
    }

    Write-Output "========================================" 
    Write-Output "Collecting dataflows"
    $dataFlows = Get-AzDataFactoryV2DataFlow -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName

    Write-Output "Found $($dataFlows.Count) data flows"
    $dataFlows | ForEach-Object -process {
        Write-Output "Removing DataFlow $($_.name)"
        Remove-AzDataFactoryV2DataFlow -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
    }

    Write-Output "========================================"
    Write-Output "Collecting datasets"
    $datasets = Get-AzDataFactoryV2Dataset -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName
    Write-Output "Found $($datasets.Count) datasets"
    $datasets | ForEach-Object -process { 
        Write-Output "Deleting dataset $($_.name)"
        Remove-AzDataFactoryV2Dataset -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
    }
    Write-Output "========================================"
    Write-Output "Collecting Linked services"
    $lservices = Get-AzDataFactoryV2LinkedService -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName | Sort-Object -Property name -Descending
    Write-Output "Found $($lservices.Count) linked services"

    $lservices | ForEach-Object -process { 
        Write-Output "Deleting linked service $($_.name)"
        Remove-AzDataFactoryV2LinkedService -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
    }

#    Write-Output "========================================"
#    Write-Output "Collecting Integration runtimes "
#    $runtimes = Get-AzDataFactoryV2IntegrationRuntime -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName
#    Write-Output "Found $($runtimes.Count) Integration Runtimes"
#    $runtimes | ForEach-Object -process { 
#        Write-Output "Deleting Integration runtime $($_.name)"
#        Remove-AzDataFactoryV2IntegrationRuntime -name $_.name -DataFactoryName $dataFactoryName -ResourceGroupName $resourceGroupName -Force 
#    }

    Write-Output "========================================"
    Write-Output "ReApply lock"

    Set-AzResourceLock -LockName "$dataFactoryName-lock" -ResourceName $dataFactoryName -ResourceGroupName $resourceGroupName -ResourceType "Microsoft.DataFactory/factories" -LockLevel CanNotDelete -Force

    Write-Output "========================================"