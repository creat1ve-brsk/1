$R = Invoke-WebRequest -URI https://www.bing.com?q=how+many+feet+in+a+mile
Write-Output $R.Links
for ($i = 0; $i -lt $R.Links.Count; $i++) {
    Write-Output $R.Links.Item($i)
    Write-Output $R.Links.Item($i).Href
    timeout.exe /T 1 1>&0
}

pause
    <#
foreach ($item in $R.Links) {

}
    $R.AllElements | Where-Object {
        $_.name -like "* Value" -and $_.tagName -eq "INPUT"
    } | Select-Object Name, Value
    #>