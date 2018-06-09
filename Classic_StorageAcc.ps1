#This script retrieves details of all the Classic storage Accounts in the subscription and exports them to CSV file.

$report = @()
$sta=Get-AzureStorageAccount
 foreach($st in $sta)
 {
  $info = "" | Select StorageAccount_Name, StorageAcc_Type ,Location ,Operation_status
  $info.StorageAccount_Name =$st.StorageAccountName
  $info.StorageAcc_Type= $st.AccountType
  $info.Location= $st.Location
  $info.Operation_status= $st.OperationStatus
 $report+=$info
}
$report | Export-Csv "c:\Classic_StorageAccounts.csv"

