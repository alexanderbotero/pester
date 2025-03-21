<#
.SYNOPSIS
    Creates a new user in the data access API.

.DESCRIPTION
    The New-DataAccessUser function creates a new user in the data access API.
    It requires the user's name and email as mandatory parameters.
    Optionally, you can provide the base URL of the data access API.

.PARAMETER Name
    The name of the user to be created. This parameter is mandatory.

.PARAMETER Email
    The email of the user to be created. This parameter is mandatory.

.PARAMETER BaseUrl
    The base URL of the data access API. This parameter is optional.

.EXAMPLE
    PS C:\> New-DataAccessUser -Name "John Doe" -Email "john.doe@example.com" -BaseUrl "https://api.example.com"
    Creating user John Doe with email john.doe@example.com

    This example shows how to call the function by providing the user's name, email, and the base URL.

.EXAMPLE
    PS C:\> New-DataAccessUser -Name "Jane Doe" -Email "jane.doe@example.com"
    Creating user Jane Doe with email jane.doe@example.com

    This example shows how to call the function by providing the user's name and email without the base URL.
#>
function New-DataAccessUser {
    [CmdletBinding()]
    param (
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
        Write-Verbose "Creating user $Name with email $Email"
        $body = @{
            name = $Name
            email = $Email
        } | ConvertTo-Json
        try {
            Invoke-RestMethod -Uri "$BaseUrl/users" -Method Post -Body $body -ContentType "application/json"
        }
        catch {
            Write-Error "Error creating user: $_"
        }
    }
}