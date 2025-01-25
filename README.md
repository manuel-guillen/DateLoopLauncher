# DateLoopLauncher
[PowerShell] Script to repeatedly launch an app in a loop of "opening" a link (.lnk) and upon closing app, incrementing date and relaunching app

## Description
This script initiates an infinite loop that sets the system date, launches an application, waits for it to close, and increments the date before repeating.
The script takes a link path and an initial count as parameters. It sets the system date based on the count parameter, starting the loop with the date set at the count parameter many days after today's date.
The script then launches the application specified by the link path, waits for the application to start and then to close, before incrementing the date by one day and repeating the launch loop.

## Examples
    .\script.ps1 -linkPath "C:\Path\To\Application.lnk" -count 5
    .\script.ps1 "C:\Path\To\Application.lnk" 5

## NOTE
Ensure you have the necessary permissions to change the system date and time (ex. Run from elevated shell / Run As Adminstrator)
