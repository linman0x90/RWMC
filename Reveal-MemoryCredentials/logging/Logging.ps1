Function Start-Log{
<#
.SYNOPSIS
These functions allow logging of scripts

.DESCRIPTION
Create a log file

.PARAMETER scriptName [mandatory]
Example: Test-log
      
.PARAMETER scriptVersion [mandatory]
Example: 1.0

.PARAMETER streamWriter [mandatory]
Stream Writer object (New-Object System.IO.StreamWriter)
This object is use to avoid open and close of the file cause
by call to Add-Content or Out-File
        
#>
    
    [CmdletBinding()]  
    Param ([Parameter(Mandatory=$true)][string]$scriptName, [Parameter(Mandatory=$true)][string]$scriptVersion, 
        [Parameter(Mandatory=$true)][string]$streamWriter)
    Process{                  
        $global:streamWriter.WriteLine("================================================================================================")
        $global:streamWriter.WriteLine("[$ScriptName] version [$ScriptVersion] started at $([DateTime]::Now)")
        $global:streamWriter.WriteLine("================================================================================================`n")       
    }
}
 
Function Write-Log{
<#
.SYNOPSIS
Write log lines

.DESCRIPTION
This function allow to append a new line at the end of the log file
  
.PARAMETER streamWriter [mandatory]
Stream Writer object
  
.PARAMETER infoToLog [mandatory]
The information line you want to write in the log file
#>
  
    [CmdletBinding()]  
    Param ([Parameter(Mandatory=$true)][string]$streamWriter, [Parameter(Mandatory=$true)][string]$infoToLog)  
    Process{    
        $global:streamWriter.WriteLine("$infoToLog")
    }
}
 
Function Write-Error{
<#
.SYNOPSIS
Write the error caught you send to this function

.DESCRIPTION
This function allow to append the error passed at the end of the log file
  
.PARAMETER streamWriter [mandatory]
Stream Writer object
  
.PARAMETER error [mandatory]
The error you want to log
  
.PARAMETER forceExit [mandatory]
Boolean value to force call to End-Log in case of force exit
--> set to true to force the script Exit 
#>
  
    [CmdletBinding()]  
    Param ([Parameter(Mandatory=$true)][string]$streamWriter, [Parameter(Mandatory=$true)][string]$errorCaught, [Parameter(Mandatory=$true)][boolean]$forceExit)  
    Process{
        $global:streamWriter.WriteLine("Error: [$errorCaught]")        
        if ($forceExit -eq $true){
            End-Log -streamWriter $global:streamWriter
            break;
        }
    }
}
 
Function End-Log{
<#
.SYNOPSIS
End of execution

.DESCRIPTION
Write date time of script ended
  
.PARAMETER logPathName [mandatory]
Stream Writer object

#>
  
    [CmdletBinding()]  
    Param ([Parameter(Mandatory=$true)][string]$streamWriter)  
    Process{    
        $global:streamWriter.WriteLine("`n================================================================================================")
        $global:streamWriter.WriteLine("Script ended at $([DateTime]::Now)")
        $global:streamWriter.WriteLine("================================================================================================")
  
        $global:streamWriter.Close()   
    }
}