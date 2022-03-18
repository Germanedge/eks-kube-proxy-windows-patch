Write-Host "applying patch to c:\install-calico-windows.ps1..."
$file = 'c:\install-calico-windows.ps1'
$regex = '(ArgumentList.*)'
(get-content $file) -replace $regex, 'Argument @{ PathName = $UpdatedPath }' |set-content $file
$regex = '(\$supportsDSR =.*)'
(get-content $file) -replace $regex, '$supportsDSR =(($OSInfo.WindowsVersion -as [int]) -GE 1903 -And ($OSInfo.OsBuildNumber -as [int]) -GE 18317)' |set-content $file
Write-Host "finished, execute install-calico-windows.ps1 now"

& c:\install-calico-windows.ps1
