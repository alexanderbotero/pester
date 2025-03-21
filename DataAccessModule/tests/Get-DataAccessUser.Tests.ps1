BeforeAll {
    Import-Module -Name "$PSScriptRoot\..\DataAccessModule.psd1","DataAccessModule" -Force 
}

Describe "Get-DataAccessUser" {
    Context "When Id is provided" {
        It "should retrieve user information for a single valid Id" {
            $mockResponse = @{
                id = "123e4567-e89b-12d3-a456-426614174000"
                name = "Sim Kovacek"
                email = "candido.rogahn79@gmail.com"
            }
            Mock -CommandName Invoke-RestMethod `
                 -MockWith { $mockResponse } `
                 -ParameterFilter { 
                    $uri -match "https://api.example.com/users/123e4567-e89b-12d3-a456-426614174000" 
                 } `
                 -ModuleName DataAccessModule
            $result = Get-DataAccessUser -Id $mockResponse.Id -BaseUrl "https://api.example.com"
            $result.id | Should -Be $mockResponse.Id
            $result.name | Should -Be $mockResponse.name
            $result.email | Should -Be $mockResponse.email
        }

        It "should retrieve user information for multiple valid Ids" {
            $mockResponses = @{}
            $keyOne = "https://api.example.com/users/123e4567-e89b-12d3-a456-426614174000"
            $keyTwo = "https://api.example.com/users/123e4567-e89b-12d3-a456-426614174001"
            $mockResponses.Add($keyOne, @{
                    id = "123e4567-e89b-12d3-a456-426614174000"
                    name = "Sim Kovacek"
                    email = "candido.rogahn79@gmail.com"
                })
            $mockResponses.Add($keyTwo, @{
                    id = "123e4567-e89b-12d3-a456-426614174001"
                    name = "Otha Parker"
                    email = "camren97@hotmail.com"
                })
            Mock -CommandName Invoke-RestMethod -MockWith {
                param ($Uri)
                $mockResponses[$Uri.OriginalString]
            } -ParameterFilter { $uri -match $keyOne -or $uri -match $keyTwo } -ModuleName DataAccessModule

            $result = Get-DataAccessUser -Id @("123e4567-e89b-12d3-a456-426614174000", "123e4567-e89b-12d3-a456-426614174001") `
                                         -BaseUrl "https://api.example.com"
            $result[0].id | Should -Be $mockResponses[$keyOne].id
            $result[0].name | Should -Be $mockResponses[$keyOne].name
            $result[0].email | Should -Be $mockResponses[$keyOne].email
            $result[1].id | Should -Be $mockResponses[$keyTwo].id
            $result[1].name | Should -Be $mockResponses[$keyTwo].name
            $result[1].email | Should -Be $mockResponses[$keyTwo].email
        }

        It "should throw an error for an invalid Id format" {
            { Get-DataAccessUser -Id "invalid-id" -BaseUrl "https://api.example.com" } | Should -Throw
        }
    }

    

    Context "When Id is not provided" {
        BeforeEach {
            # Clear the environment variable before each test
            Remove-Item -Path Env:DATA_LAYER_API -ErrorAction SilentlyContinue
        }

        It "should retrieve all users when no Id is provided" {
            $mockResponse = @(
                @{
                    id = "123e4567-e89b-12d3-a456-426614174000"
                    name = "Sim Kovacek"
                    email = "candido.rogahn79@gmail.com"
                },
                @{
                    id = "123e4567-e89b-12d3-a456-426614174001"
                    name = "Otha Parker"
                    email = "camren97@hotmail.com"
                }
            )
            Mock -CommandName Invoke-RestMethod -MockWith { $mockResponse } -ModuleName DataAccessModule

            $result = Get-DataAccessUser -BaseUrl "https://api.example.com"
            $result[0].id | Should -Be $mockResponse[0].id
            $result[0].name | Should -Be $mockResponse[0].name
            $result[0].email | Should -Be $mockResponse[0].email
            $result[1].id | Should -Be $mockResponse[1].id
            $result[1].name | Should -Be $mockResponse[1].name
            $result[1].email | Should -Be $mockResponse[1].email
        }

    }
}