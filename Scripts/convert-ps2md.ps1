<#
.SYNOPSIS
	convert-ps2md.ps1 [<filename>]
.DESCRIPTION
	Converts the comment-based help of a PowerShell script to Markdown.
.EXAMPLE
	PS> .\convert-ps2md.ps1 myscript.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$filename = "")

function EncodePartOfHtml { param([string]$Value)
    ($Value -replace '<', '&lt;') -replace '>', '&gt;'
}

function GetCode { param($Example)
    $codeAndRemarks = (($Example | Out-String) -replace ($Example.title), '').Trim() -split "`r`n"

    $code = New-Object "System.Collections.Generic.List[string]"
    for ($i = 0; $i -lt $codeAndRemarks.Length; $i++) {
        if ($codeAndRemarks[$i] -eq 'DESCRIPTION' -and $codeAndRemarks[$i + 1] -eq '-----------') {
            break
        }
        if (1 -le $i -and $i -le 2) {
            continue
        }
        $code.Add($codeAndRemarks[$i])
    }

    $code -join "`r`n"
}

function GetRemark { param($Example)
    $codeAndRemarks = (($Example | Out-String) -replace ($Example.title), '').Trim() -split "`r`n"

    $isSkipped = $false
    $remark = New-Object "System.Collections.Generic.List[string]"
    for ($i = 0; $i -lt $codeAndRemarks.Length; $i++) {
        if (!$isSkipped -and $codeAndRemarks[$i - 2] -ne 'DESCRIPTION' -and $codeAndRemarks[$i - 1] -ne '-----------') {
            continue
        }
        $isSkipped = $true
        $remark.Add($codeAndRemarks[$i])
    }

    $remark -join "`r`n"
}

try {
	if ($filename -eq "") { $filename = read-host "Enter path to PowerShell script" }
	$ScriptName = (get-item "$filename").Name

	$full = Get-Help $filename -Full 

	"# Help for $ScriptName PowerShell Script"

	""
	"## Synopsis & Description"
	"``````powershell"
	"$($full.Synopsis)"
	"``````"

	$Description = ($full.description | Out-String).Trim()
	if ($Description -ne "") {
		""
		"$Description"
	}

	$Syntax = (($full.syntax | Out-String) -replace "`r`n", "`r`n`r`n").Trim()
	if ($Syntax -ne "") {
		""
		"## Syntax & Parameters"
		"``````powershell"
		"$Syntax"
		"``````"
	}

	foreach($parameter in $full.parameters.parameter) {
		""
		"``````"
		"$(((($parameter | Out-String).Trim() -split "`r`n")[-5..-1] | % { $_.Trim() }) -join "`r`n")"
		"``````"
	}
	""
	"``````"
	"[<CommonParameters>]"
	"    This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, "
	"    WarningVariable, OutBuffer, PipelineVariable, and OutVariable."
	"``````"

	foreach($input in $full.inputTypes.inputType) {
		""
		"## Inputs"
		"$($input.type.name)"
	}

	foreach($output in $full.outputTypes.outputType) {
		""
		"## Outputs"
		"$($output.type.name)"
	}

	foreach($example in $full.examples.example) {
		""
		"## Example"
		"``````powershell"
		"$(GetCode $example)"
		"``````"
		"$(GetRemark $example)"
	}

	$Notes = ($full.alertSet.alert | Out-String).Trim()
	if ($Notes -ne "") {
		""
		"## Notes"
		"$Notes"
	}

	$Links = ($full.relatedlinks | Out-String).Trim()
	if ($Links -ne "") {
		""
		"## Related Links"
		"$Links"
	}

	""
	"*Generated from comment-based help of $ScriptName by convert-ps2md.ps1*"
} catch {
        write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}
