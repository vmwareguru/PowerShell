﻿<#
.SYNOPSIS
	Tells a quote by text-to-speech
.DESCRIPTION
	This script selects a random quote in Data/quotes.csv and speaks it by text-to-speech (TTS).
.EXAMPLE
	PS> ./tell-quote
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Table = import-csv "$PSScriptRoot/../Data/quotes.csv"

	$Generator = New-Object System.Random
	$Index = [int]$Generator.next(0, $Table.Count - 1)
	$Quote = $Table[$Index].Quote
	$Author = $Table[$Index].Author
	$Answer = "$Quote (by $Author)"

	& "$PSScriptRoot/speak-english.ps1" "$Answer"
	write-output "$Answer"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}