#This script retrieves the details of all the Application Insights in the Subscription and exports them to a CSV file.

$report = @()
$appins= Get-AzureRmApplicationInsights
foreach($appin in $appins)
{
$info = "" | Select AppInsights_Name, Location,  ResourceGroupName , kind ,RequestSource ,InstrumentationKey ,FlowType ,PricingPlan
$info.AppInsights_Name = $appin.Name
$info.Location= $appin.Location
$info.ResourceGroupName= $appin.ResourceGroupName
$info.kind= $appin.Kind
$info.RequestSource= $appin.RequestSource
$info.InstrumentationKey =$appin.InstrumentationKey
$info.FlowType = $appin.FlowType
$a = Get-AzureRmApplicationInsights -Name $appin.Name -ResourceGroupName $appin.ResourceGroupName -IncludePricingPlan
$info.PricingPlan = $a.PricingPlan
$report+=$info
   }
   $report | Export-Csv "c:\ApplicationInsights.csv"