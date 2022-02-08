# eks-kube-proxy-windows-patch
contains a script to patch the calico installer

Reason for doing this patch:
The calico intaller will error out on the current windowsserver20h2corecontainer AMI while changing the start parameter of the windows service because on the current version the parameter of Invoke-CimMethod does not support -ArgumentList.

 Add this to your eks-node boostrapping script like this:
```  preBootstrapCommands:
    - '& mkdir c:\k'
    - '& Invoke-WebRequest https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.5/2022-01-21/bin/windows/amd64/kubectl.exe -OutFile c:\k\kubectl.exe'
    - '& Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name PATH -Value "$ENV:PATH ;C:\k"'
    - '& Invoke-WebRequest https://docs.projectcalico.org/scripts/install-calico-windows.ps1 -OutFile c:\install-calico-windows.ps1'
    - '& Invoke-WebRequest https://github.com/Germanedge/eks-kube-proxy-windows-patch/blob/0.0.3/eks-calico-patch.ps1 -Outfile c:\eks-calico-patch.ps1'
    - '& c:\eks-calico-patch.ps1'
    - '& c:\install-calico-windows.ps1'
 ```


Check/debug services:
```
Get-CimInstance win32_service -filter 'Name="kube-proxy"' | Format-List -Property *
Get-CimInstance win32_service -filter 'Name="kube-proxy"' | Invoke-CimMethod -Name Change -Argument @{ PathName = $UpdatedPath }
restart-Service -name "kube-proxy"
```
