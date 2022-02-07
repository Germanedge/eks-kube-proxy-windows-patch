Write-Host "applying patch to c:\install-calico-windows.ps1..."
$file = 'c:\install-calico-windows.ps1'
$regex = '(ArgumentList.*)'
(get-content $file) -replace $regex, 'Argument @{ PathName, $UpdatedPath}' |set-content $file
Write-Host "executing to c:\install-calico-windows.ps1..."
& c:\install-calico-windows.ps1
