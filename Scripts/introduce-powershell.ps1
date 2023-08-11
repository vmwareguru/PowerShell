﻿<#
.SYNOPSIS
	Introduces PowerShell to new users
.DESCRIPTION
	This PowerShell script introduces PowerShell to new users.
.EXAMPLE
	PS> ./introduce-powershell.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Clear-Host
	""
	& "$PSScriptRoot/write-typewriter.ps1" " There is one shell to rule them all:" 200
	""
	Write-Host "  _____                       _____ _          _ _ " -foregroundColor blue
	Write-Host " |  __ \                     / ____| |        | | |" -foregroundColor blue
	Write-Host " | |__) |____      _____ _ _| (___ | |__   ___| | |" -foregroundColor blue
	Write-Host " |  ___/ _ \ \ /\ / / _ \ '__\___ \| '_ \ / _ \ | |" -foregroundColor blue
	Write-Host " | |  | (_) \ V  V /  __/ |  ____) | | | |  __/ | |" -foregroundColor blue
	Write-Host " |_|   \___/ \_/\_/ \___|_| |_____/|_| |_|\___|_|_|" -foregroundColor blue
	""
	""
	$Version = $PSVersionTable.PSVersion
	$Edition = $PSVersionTable.PSEdition
	$NumModules = (Get-Module).Count
	$NumAliases = (Get-Alias).Count
	$Details = "PowerShell $Version ($Edition edition) with $NumModules modules and $NumAliases aliases."
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Welcome to $Details" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "PowerShell is open-source and free! It's available for Linux, Mac OS and Windows." 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Curious? Take a look under the hood at: https://github.com/PowerShell/PowerShell" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Want to learn PowerShell? See the tutorials at: https://www.guru99.com/powershell-tutorial.html" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Need docs? See the official documentation at: https://docs.microsoft.com/en-us/powershell" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Want sample scripts? See the Mega Collection of PowerShell scripts at: https://github.com/fleschutz/PowerShell" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Want to donate? Great, just follow this link: https://www.paypal.com/paypalme/Fleschutz" 25
	""
	Write-Host " 🔷 " -noNewline
	& "$PSScriptRoot/write-typewriter.ps1" "Any questions? See the PowerShell FAQ at: https://github.com/fleschutz/PowerShell/blob/master/Docs/FAQ.md" 25
	""
	& "$PSScriptRoot/write-typewriter.ps1" "    (use <Ctrl> + <Click> to open the links above in your browser)" 100
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
