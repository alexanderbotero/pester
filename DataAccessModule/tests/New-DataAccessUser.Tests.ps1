BeforeAll {
    Import-Module -Name "$PSScriptRoot\..\DataAccessModule.psd1","DataAccessModule" -Force 
}

Describe "New-DataAccessUser" {
    Context "When Name and Email are provided" {
        It "should create a new user with the provided Name and Email" {
            $mockResponse = @{
                id = "123e4567-e89b-12d3-a456-426614174000"
                name = "John Doe"
                email = "john.doe@example.com"
            }
            Mock -CommandName Invoke-RestMethod `
                -MockWith { $mockResponse } `
                -ParameterFilter { 
                    $uri -match "https://api.example.com/users" -and $method -match "Post" 
                } `
                -ModuleName DataAccessModule

            $result = New-DataAccessUser -Name "John Doe" `
                                         -Email "john.doe@example.com" `
                                         -BaseUrl "https://api.example.com"
            $result.id | Should -Be $mockResponse.id
            $result.name | Should -Be $mockResponse.name
            $result.email | Should -Be $mockResponse.email
        }

        It "should create a new user with the provided Name and Email without BaseUrl" {
            $mockResponse = @{
                id = "123e4567-e89b-12d3-a456-426614174000"
                name = "Jane Doe"
                email = "jane.doe@example.com"
            }
            Mock -CommandName Invoke-RestMethod -MockWith { $mockResponse } `
                                                -ParameterFilter { $uri -match "https://api.example.com/users" -and $method -match "Post" } `
                                                -ModuleName DataAccessModule

            $env:DATA_LAYER_API = "https://api.example.com"
            $result = New-DataAccessUser -Name $mockResponse.name -Email $mockResponse.email
            $result.id | Should -Be $mockResponse.id
            $result.name | Should -Be $mockResponse.name
            $result.email | Should -Be $mockResponse.email
        }
    }
}