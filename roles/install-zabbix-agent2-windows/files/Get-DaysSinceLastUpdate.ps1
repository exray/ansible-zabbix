$Date = Get-Date
$Diff = (Get-Hotfix | Sort-Object -Property InstalledOn)[-1] | Select-Object InstalledOn
$Diff3 = New-TimeSpan -Start $Diff.InstalledOn -End $Date
Write-Host $Diff3.Days