<#
.SYNOPSIS
    This script initiates an infinite loop that sets the system date, launches an application, waits for it to close, and increments the date before repeating
.DESCRIPTION
    The script takes a link path and a count as parameters. It sets the system date based on the count parameter, starting the loop at today + count days,
    The script then launches the application specified by the link path, waits for the application to start and then to close, before incrementing the date 
    by one day and repeating the launch loop.
.PARAMETER linkPath
    The path to the application link to be launched. This is a mandatory parameter.
.PARAMETER count
    The number of days to add to the current date. This is a mandatory parameter.
.EXAMPLE
    .\script.ps1 -linkPath "C:\Path\To\Application.lnk" -count 5
.EXAMPLE
    .\script.ps1 "C:\Path\To\Application.lnk" 5
.NOTES
    Ensure you have the necessary permissions to change the system date and time.
#>

param (
    [Parameter(Mandatory=$true)][string]$linkPath,
    [Parameter(Mandatory=$true)][int]$count
)

try {
    while($true) {
        # Set the date
        $baseDate = Get-Date                 # Change starting date here if needed (ex. [datetime]"2024-12-27")
        $newDate = $baseDate.AddDays($count)
        Set-Date -Date $newDate
        
        # Launch
        Invoke-Item $linkPath
        
        # Extract the name of the main process (to be looked for) from the link
        $processName = [System.IO.Path]::GetFileNameWithoutExtension($linkPath)
        
        # Wait for the main process to start
        $process = $null
        while (-not $process) {
            Start-Sleep -Seconds 1
            $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
        }
        
        # Wait for the process to exit
        Write-Output("Waiting for application to close...")
        $process.WaitForExit()

        $count++
        Write-Output("$count completed.`n")
    }
}
finally {
    # Reset the date/time
    w32tm /resync /force
}
