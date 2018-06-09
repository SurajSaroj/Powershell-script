$report = @()
$vms = get-azurermvm
$nics = get-azurermnetworkinterface | ?{ $_.VirtualMachine -NE $null}
$pip= Get-AzureRmPublicIpAddress
 
foreach($nic in $nics)
{
    $info = "" | Select VmName, ResourceGroupName, HostName, PrivateIpAddress , VmSize , DataDiskCount ,DiskName ,DiskSize ,Location ,OStype,Nic ,PublicIP ,BootDiagnosticsStatus ,BootDiagacc, PrivateIptype ,PublicIptype ,Vnet, Subnet ,Status
    $vm = $vms | ? -Property Id -eq $nic.VirtualMachine.id
    $info.VMName = $vm.Name
    $info.ResourceGroupName = $vm.ResourceGroupName
    
    $info.PrivateIpAddress = $nic.IpConfigurations.PrivateIpAddress
    $info.HostName = $vm.OSProfile.ComputerName
    $info.VmSize= $vm.HardwareProfile.VmSize
    $info.DataDiskCount= $vm.StorageProfile.DataDisks.Count
    $info.DiskName= $vm.StorageProfile.OsDisk.Name
    $dd= Get-AzureRmDisk -DiskName $vm.StorageProfile.OsDisk.Name -ResourceGroupName $vm.ResourceGroupName
    $info.DiskSize= $dd.DiskSizeGB
    $info.Location= $vm.Location
    $info.OStype= $vm.StorageProfile.OsDisk.OsType
    $info.Nic= $nic.Name
    $nicname= $nic.Name
   $info.PrivateIPtype= $nic.IpConfigurations.PrivateIpAllocationMethod
    $Public= $pip.Where({$_.Id -eq $nic.IpConfigurations.publicipaddress.id})
   $info.PublicIP= $Public.IpAddress
    $pip= Get-AzureRmPublicIpAddress -Name $pipname -ResourceGroupName $v[4]
    $info.PublicIptype=$pip.PublicIpAllocationMethod
    $info.BootDiagnosticsStatus = $vm.DiagnosticsProfile.BootDiagnostics.Enabled
    $info.BootDiagacc = $vm.DiagnosticsProfile.BootDiagnostics.StorageUri
    $str= $nic.IpConfigurations.Subnet.Id
    $var=$str.Split("/")
    $vnet=$var[8]
    $info.Vnet= $vnet
    $info.Subnet= $var[10]
    $res=$vm.ResourceGroupName
    $n=$info.VMName = $vm.Name
    #$xyz= Get-AzureRmVM -ResourceGroupName $res -Name $n -Status
    #$info.Status= $xyz.Statuses[1][0].DisplayStatus
    
    
    $report+=$info
}
$report | Export-Csv "c:\AzureResources.csv"
