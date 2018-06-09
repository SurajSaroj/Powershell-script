#This Script retrives details of all the Classic Virtual machines ans exports them to CSV file
$report = @()
$vms = Get-AzureVM

 
 foreach($vm in $vms)
{
    $info = "" | Select VM_Name, ServiceName, PrivateIpAddress , VM_Size ,OS_DiskName ,OS_DiskSize  ,ReservedIpName ,Location ,OSType ,PublicIP ,VirtualNetworkName,Status,DeploymentName,OSVersion
    
    $info.VM_Name = $vm.Name
    $name=$vm.Name
    $info.ServiceName = $vm.ServiceName
    $info.VM_Size= $vm.InstanceSize
    $info.VirtualNetworkName= (Get-AzureDeployment -ServiceName $vm.ServiceName).VNetName
    $info.PublicIP =$vm.PublicIPName
    $info.PrivateIpAddress =$vm.IpAddress
    $info.Status= $vm.PowerState
    $info.OS_DiskSize= $disk.DiskSizeInGB
    $info.OS_DiskName = $disk.DiskName
    $disk=Get-AzureDisk -DiskName  $vm.VM.OSVirtualHardDisk.DiskName
    $info.OSType = $disk.OS
    $info.Location= $disk.Location
    $info.PublicIP = (Get-AzureDeployment -ServiceName $vm.ServiceName).VirtualIPs.address
    $info.DeploymentName=(Get-AzureDeployment -ServiceName $vm.ServiceName).DeploymentName
    $info.ReservedIpName=(Get-AzureDeployment -ServiceName $vm.ServiceName).ReservedIPName
    $info.OSVersion= (Get-AzureDeployment -ServiceName $vm.ServiceName).OSVersion
    
    $report+=$info
}
$report | Export-Csv "c:\Classic_VirtualMachines.csv"

