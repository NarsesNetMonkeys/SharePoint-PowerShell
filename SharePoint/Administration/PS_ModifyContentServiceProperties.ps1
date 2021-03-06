############################################################################################################################################
# This script shows how to modify properties for the Web Service Content Service in a SharePoint Farm
# Required Parameters: 
#    ->$sOperationType: Operation Type.
#    ->$sPropertyValue: Property value
############################################################################################################################################

If ((Get-PSSnapIn -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null ) 
{ Add-PSSnapIn -Name Microsoft.SharePoint.PowerShell }

$host.Runspace.ThreadOptions = "ReuseThread"

#
#Definition of the function that allows to modify properties in the Content Service
#
function ModifyContentServiceProperties
{
    param ($sOperationType)
    try
    {
        # Content Web Service
        $spContentService = [Microsoft.SharePoint.Administration.SPWebService]::ContentService        
        switch ($sOperationType,$sPropertyValue) 
        { 
        "Modify" {            
            Write-Host "Modifiyng the property RemoteAdministratorAccessDenied - For Timer Jobs debugging!!" -ForegroundColor Green                                    
            $spContentService.RemoteAdministratorAccessDenied = $sPropertyValue
            $spContentService.Update()
            break
            } 
        "Read" {
            Write-Host "Reading the Content Service properties values" -ForegroundColor Green
            #$spContentService.RemoteAdministratorAccessDenied
	    $spContentService
            break
            }     
        default {
            Write-Host "The requested operation is wrong!!" -ForegroundColor DarkBlue            
            }
        }
    }
    catch [System.Exception]
    {
        write-host -f red $_.Exception.ToString()
    }
}

Start-SPAssignment –Global
#Calling the function
$sPropertyValue=$false
ModifyContentServiceProperties -sOperationType "Modify" -sPropertyValue $sPropertyValue
ModifyContentServiceProperties  -sOperationType "Read" -sPropertyValue $sPropertyValue

Stop-SPAssignment –Global

Remove-PSSnapin Microsoft.SharePoint.PowerShell