Write-Host "adding hook to c:\program files\Amazon\EKS\EKS-StartupTask.ps1"
$file = 'c:\program files\Amazon\EKS\EKS-StartupTask.ps1'

Add-Content $file "# custom hook for kube-proxy patch"
Add-Content $file "& c:\eks-calico-patch.ps1"
