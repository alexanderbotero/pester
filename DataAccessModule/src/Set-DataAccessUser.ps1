<#
.SYNOPSIS
    Updates an existing user in the data access API.

.DESCRIPTION
    The Set-DataAccessUser function updates an existing user in the data access API.
    It requires the user's ID, name, and email as mandatory parameters.
    Optionally, you can provide the base URL of the data access API.

.PARAMETER Id
    The ID of the user to be updated. This parameter is mandatory and must be a valid GUID.

.PARAMETER Name
    The new name of the user. This parameter is mandatory.

.PARAMETER Email
    The new email of the user. This parameter is mandatory.

.PARAMETER BaseUrl
    The base URL of the data access API. This parameter is optional.

.EXAMPLE
    PS C:\> Set-DataAccessUser -Id "123e4567-e89b-12d3-a456-426614174000" -Name "John Doe" -Email "john.doe@example.com" -BaseUrl "https://api.example.com"
    Updating user 123e4567-e89b-12d3-a456-426614174000 set name John Doe and email john.doe@example.com

    This example shows how to call the function by providing the user's ID, new name, new email, and the base URL.

.EXAMPLE
    PS C:\> Set-DataAccessUser -Id "123e4567-e89b-12d3-a456-426614174000" -Name "Jane Doe" -Email "jane.doe@example.com"
    Updating user 123e4567-e89b-12d3-a456-426614174000 set name Jane Doe and email jane.doe@example.com

    This example shows how to call the function by providing the user's ID, new name, and new email without the base URL.

#>
function Set-DataAccessUser {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidatePattern('^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')]
        [string]$Id,
        [Parameter(Mandatory)]
        [string]$Name,
        [Parameter(Mandatory)]
        [string]$Email,
        [string]$BaseUrl
    )
    begin {
        $BaseUrl = Get-DataAccessBaseUrl -BaseUrl $BaseUrl
    }
    process {
        Write-Verbose "Updating user $Id set name $Name and email $Email"
        $body = @{
            name = $Name
            email = $Email
        } | ConvertTo-Json
        try {
            Invoke-RestMethod -Uri "$BaseUrl/users/$Id" -Method Put -Body $body -ContentType "application/json"
        }
        catch {
            Write-Error "Error updating user $Id : $_"
        }
    }
}