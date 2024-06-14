function stopserviceElevated {

    param (
	[Parameter(Mandatory=$true)]
	[string]$ServiceName
    )
	
    $arrService = Get-Service -Name $ServiceName
    if ($arrService.Status -eq 'Running')
    {
	[System.Media.SystemSounds]::Asterisk.Play()

        Write-Host "WARNING: $($ServiceName) is Running"
	Write-Host "Stopping $ServiceName"

	Start-Process powershell -ArgumentList "-NoProfile -Command `"Stop-Service -Name '$ServiceName'`"" -Verb RunAs
	Read-Host -Prompt "Press enter to continue..."

	$arrService = Get-Service -Name $ServiceName
	if ($arrService.Status -eq 'Stopped')
	{
		Write-Host "$ServiceName Stopped"
	}
	else
	{
		Write-Host "Failed to stop $ServiceName"
	}

	Read-Host -Prompt "Press enter to continue..."
    }
    else
    {
	Write-Host "CLEAR: $($ServiceName) is NOT Running"
	Read-Host -Prompt "Press enter to continue..."
    }
}

stopserviceElevated -ServiceName 'Windows Update'
stopserviceElevated -ServiceName 'Background Intelligent Transfer Service'
stopserviceElevated -ServiceName 'Update Orchestrator Service'
stopserviceElevated -ServiceName 'Delivery Optimization'

Exit