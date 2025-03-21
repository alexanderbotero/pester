<#
.SYNOPSIS
    Retrieves user information from the data access API.

.DESCRIPTION
    The Get-DataAccessUser function retrieves user information from the data access API.
    If one or more user IDs are provided, it retrieves information for those specific users.
    If no user IDs are provided, it retrieves information for all users.

.PARAMETER Id
    An array of user IDs to retrieve information for. This parameter is optional.

.PARAMETER BaseUrl
    The base URL of the data access API. This parameter is optional.

.EXAMPLE
    PS C:\> Get-DataAccessUser -Id "123e4567-e89b-12d3-a456-426614174000" -BaseUrl "https://api.example.com"

    id                                   name        email
    --                                   ----        -----
    123e4567-e89b-12d3-a456-426614174000 Sim Kovacek candido.rogahn79@gmail.com

    This example shows how to call the function by providing one user ID and the base URL.

.EXAMPLE
    PS C:\> Get-DataAccessUser -Id "123e4567-e89b-12d3-a456-426614174000"

    id                                   name        email
    --                                   ----        -----
    123e4567-e89b-12d3-a456-426614174000 Sim Kovacek candido.rogahn79@gmail.com

    This example shows how to call the function by providing one user ID and without the base URL.

.EXAMPLE
    PS C:\> Get-DataAccessUser -Id "123e4567-e89b-12d3-a456-426614174000", "123e4567-e89b-12d3-a456-426614174001" -BaseUrl "https://api.example.com"
    id                                   name        email
    --                                   ----        -----
    123e4567-e89b-12d3-a456-426614174000 Sim Kovacek candido.rogahn79@gmail.com
    123e4567-e89b-12d3-a456-426614174001 Otha Parker camren97@hotmail.com

    This example shows how to call the function by providing multiple user IDs and the base URL.

.EXAMPLE
    PS C:\> Get-DataAccessUser -BaseUrl "https://api.example.com"
    Retrieving all users from url https://api.example.com/users

    id                                   name        email
    --                                   ----        -----
    123e4567-e89b-12d3-a456-426614174000 Sim Kovacek candido.rogahn79@gmail.com
    123e4567-e89b-12d3-a456-426614174001 Otha Parker camren97@hotmail.com

    This example shows how to call the function to retrieve information for all users by providing only the base URL.

#>
function Get-DataAccessUser {
    [CmdletBinding()]
    param (
        [ValidatePattern('^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')]
        [string[]]$Id,
        [string]$BaseUrl
    )
    begin {
        $BaseUrl = Get-DataAccessBaseUrl -BaseUrl $BaseUrl
    }
    process {
        if ($Id) {
            $Id | ForEach-Object {
                try {
                    $userId = $_
                    $url = "$BaseUrl/users/$userId"
                    Write-Verbose "Retrieving user $userId from url $url"
                    Invoke-RestMethod -Uri $url -Method Get
                } catch {
                    Write-Verbose "Status code: $($_.Exception.Response.StatusCode)"
                    if ($_.Exception.Response.StatusCode -eq 404) {
                        Write-Error "User $userId not found"
                    } else {
                        Write-Error "Error accessing API: $_"
                    }
                }
            }
        } else {
            Invoke-RestMethod -Uri "$BaseUrl/users" -Method Get
        }
    }
}