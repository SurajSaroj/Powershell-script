#This Script retrieves  details of all the  AppService Plans and exports them to the CSV file.

$report = @()
$sers=Get-AzureRmAppServicePlan
foreach($ser in $sers)
{
 $info = "" | Select ASP_Name, Location,  ResourceGroupName ,ASP_SizeInstanceCount,Status, Max_Worker, NumberOfApps,ASP_Tier
 $info.ASP_Name= $ser.Name

 $info.Location=$ser.Location
 $info.ResourceGroupName=$ser.ResourceGroup
 $t=Get-AzureRmAppServicePlan -Name $ser.Name -ResourceGroupName $ser.ResourceGroup
 $info.ASP_Tier=$t.Sku.Tier
 $info.ASP_SizeInstanceCount= $t.Sku.Size
 $info.Status= $ser.Status
 $info.Max_Worker= $ser.MaximumNumberOfWorkers
 $info.NumberOfApps=$ser.NumberOfSites


   $report+=$info
   }
   $report | Export-Csv "c:\AppServicePlans.csv"