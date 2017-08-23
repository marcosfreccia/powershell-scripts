[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null 
$srv = new-object ('Microsoft.SqlServer.Management.Smo.Server')

#This sets the connection to mixed-mode authentication 
$srv.ConnectionContext.LoginSecure=$true; 

$srv.ConnectionContext.ApplicationName = "PowerShell Script" 


$db = New-Object Microsoft.SqlServer.Management.Smo.Database
$db = $srv.Databases.Item("master")
$db.ExecuteNonQuery("CHECKPOINT")

$SumErrorlog  = (Get-ChildItem $srv.ErrorlogPath -Filter ERRORLOG | Measure-Object -Sum Length).Sum

$SizeResult = ($SumErrorlog/1MB)

if($SizeResults -gt 250) {$db.ExecuteNonQuery("exec sp_cycle_errorlog")}
