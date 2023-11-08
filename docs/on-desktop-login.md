*on-desktop-login.ps1*
================

This PowerShell script executes useful tasks on every desktop login by the user (e.g. open Web dashboards, list the news, fetch repos).
NOTE: For installation on Windows create and put a symbolic link to this script into the Autostart folder (usually at: C:\Users\<USERNAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup).

Parameters
----------
```powershell
PS> ./on-desktop-login.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./on-desktop-login.ps1

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Executes tasks on desktop login
.DESCRIPTION
	This PowerShell script executes useful tasks on every desktop login by the user (e.g. open Web dashboards, list the news, fetch repos).
	NOTE: For installation on Windows create and put a symbolic link to this script into the Autostart folder (usually at: C:\Users\<USERNAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup).
.EXAMPLE
	PS> ./on-desktop-login.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	& "$PSScriptRoot/write-big.ps1" "Welcome back"
	" "
	& "$PSScriptRoot/open-dashboards.ps1"
	" "
	& "$PSScriptRoot/write-quote.ps1"
	" "
	& "$PSScriptRoot/list-news.ps1"
	" "
	& "$PSScriptRoot/write-joke.ps1"
	" "
	& "$PSScriptRoot/cd-repos.ps1"
	& "$PSScriptRoot/fetch-repos.ps1"
	" "
	& "$PSScriptRoot/write-clock.ps1"
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}
```

*(generated by convert-ps2md.ps1 using the comment-based help of on-desktop-login.ps1 as of 10/19/2023 08:11:40)*