<#
.SYNOPSIS
    Removes an existing user from the data access API.

.DESCRIPTION
    The Remove-DataAccessUser function removes an existing user from the data access API.
    It requires the user's ID as a mandatory parameter.
    Optionally, you can provide the base URL of the data access API.

.PARAMETER Id
    The ID of the user to be removed. This parameter is mandatory and must be a valid GUID.

.PARAMETER BaseUrl
    The base URL of the data access API. This parameter is optional.

.EXAMPLE
    PS C:\> Remove-DataAccessUser -Id "123e4567-e89b-12d3-a456-426614174000" -BaseUrl "https://api.example.com"
    Removing user 123e4567-e89b-12d3-a456-426614174000

    This example shows how to call the function by providing the user's ID and the base URL.

.EXAMPLE
    PS C:\> Remove-DataAccessUser -Id "123e4567-e89b-12d3-a456-426614174000"
    Removing user 123e4567-e89b-12d3-a456-426614174000

    This example shows how to call the function by providing the user's ID without the base URL.

#>
function Remove-DataAccessUser {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidatePattern('^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')]
        [string]$Id,
        [string]$BaseUrl
    )
    begin {
        $BaseUrl = Get-DataAccessBaseUrl -BaseUrl $BaseUrl
    }
    process {
        Write-Verbose "Removing user $Id"
        try {
            Invoke-RestMethod -Uri "$BaseUrl/users/$Id" -Method Delete -ContentType "application/json"
        }
        catch {
            Write-Error "Error removing user $Id : $_"
        }
    }
}