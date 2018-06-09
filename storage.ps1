#This script retrieves details of all the storage accounts in the subscription and exports them to a CSV file
$report = @()
$sta= Get-AzureRmStorageAccount

foreach($st in $sta)
{
 $info = "" | Select StorageAccountName, Location, Type, ResourceGroupName, Encryption_Status

  $info.StorageAccountName = $st.StorageAccountName
  $na=$st.StorageAccountName
  $info.Location= $st.Location
  $info.ResourceGroupName= $st.ResourceGroupName
  $res= $st.ResourceGroupName
  $info.Type= (Get-AzureRmStorageAccount -ResourceGroupName $res -Name $na).Sku.Name
  $info.Encryption_Status= $st.Encryption.Services.Blob.Enabled
  
  
   $report+=$info
   }
   $report | Export-Csv "c:\Az_StorageAccounts.csv"