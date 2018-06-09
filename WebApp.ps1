#This script retrieves details of all the WebApps in the suscription and exports them to csv file.
$report = @()
$apps = Get-AzureRmWebApp
foreach($app in $apps)
{
 $info = "" | Select WebApp_Name, Location, SSL_Certs, ResourceGroupName, WebAppSlotsName , Status ,AppServicePlanName, ASP_Tier, ASP_SizeInstanceCount
$info.WebApp_Name= $app.Name
$info.Location= $app.Location
$info.ResourceGroupName= $app.ResourceGroup
$info.SSL_Certs=$app.ClientCertEnabled
$s=Get-AzureRmWebAppSlot -Name $app.Name -ResourceGroupName $app.ResourceGroup
$info.WebAppSlotsName= $s.Name
$info.Status=$app.State
$str= $app.ServerFarmId
# spliting the ServerFarmId into parts separated by '/' and storing them into an array
$var = $Str.Split("/")
# retrieving the required part of the ServerFarm Id by using the array index
$info.AppServicePlanName=$var[8]
$appservice=$var[8]
$plan= Get-AzureRmAppServicePlan -Name $appservice
$info.ASP_Tier=$plan.Sku.Tier
$info.ASP_SizeInstanceCount= $plan.Sku.Size


   $report+=$info
   }
   $report | Export-Csv "c:\AZ_WebApps.csv"