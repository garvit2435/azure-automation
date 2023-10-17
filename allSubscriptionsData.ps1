$subscriptionFilter = ("Sub1", "Sub2")
$output = New-Object System.Collections.Generic.List[Object]
$subscription = Get-AzSubscription | Where-Object Name -in $subscriptionFilter 
$subscription | ForEach-Object { 
    $sName = $_.Name
    Get-AzDatabricksWorkspace -SubscriptionId $_.Id | ForEach-Object {
        $object = [PSCustomObject]@{
            WorkspaceName     = $_.Name
            SubscriptionName  = $sName
            ResourceGroupName = $_.ResourceGroupName
            Location          = $_.Location
            ResourceGroupId   = $_.ManagedResourceGroupId
        }    
        $output.Add($object)
    }
}
Write-Output $output | Format-Table
