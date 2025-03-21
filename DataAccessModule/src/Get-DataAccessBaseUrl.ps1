<#
.SYNOPSIS
    Retrieves the base URL of the data access API.

.DESCRIPTION
    The Get-DataAccessBaseUrl function returns the base URL of the data access API.
    If a base URL is not provided as a parameter, the function will attempt to obtain it
    from the DATA_LAYER_API environment variable. If this variable is also not set,
    an exception will be thrown.

.PARAMETER BaseUrl
    The base URL of the data access API. This parameter is optional.

.EXAMPLE
    PS C:\> Get-DataAccessBaseUrl -BaseUrl "https://api.example.com"
    https://api.example.com

    This example shows how to call the function by directly providing the base URL.

.EXAMPLE
    PS C:\> $env:DATA_LAYER_API = "https://api.example.com"
    PS C:\> Get-DataAccessBaseUrl
    https://api.example.com

    This example shows how the function retrieves the base URL from the DATA_LAYER_API environment variable.

.EXAMPLE
    PS C:\> Get-DataAccessBaseUrl
    BaseUrl not provided and DATA_LAYER_API environment variable is not set.

    This example shows the error message that is thrown when neither a base URL is provided
    nor the DATA_LAYER_API environment variable is set.

#>
function Get-DataAccessBaseUrl {
    [CmdletBinding()]
    param (
        [ValidatePattern('^(https?)://[^\s/$.?#].[^\s]*$|^$')]
        [string]$BaseUrl
    )
    process {
        if (-not $BaseUrl) {
            Write-Debug "No BaseUrl provided. Checking DATA_LAYER_API environment variable."
            $BaseUrl = $env:DATA_LAYER_API
            if (-not $BaseUrl) {
                Write-Debug "DATA_LAYER_API environment variable not set."
                throw "BaseUrl not provided and DATA_LAYER_API environment variable is not set."
            }
        }
        $BaseUrl.TrimEnd('/')
    }
}