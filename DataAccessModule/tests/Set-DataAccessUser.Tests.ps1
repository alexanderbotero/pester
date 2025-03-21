BeforeAll {
    Import-Module -Name "$PSScriptRoot\..\DataAccessModule.psd1", "DataAccessModule" -Force
}

Describe "Set-DataAccessUser" {
    Context "When Id, Name, and Email are provided" {
        It "should update the user with the provided Id, Name, and Email" {
            $mockResponse = @{
                id = "123e4567-e89b-12d3-a456-426614174000"
                name = "John Doe"
                email = "john.doe@example.com"
            }
            Mock -CommandName Invoke-RestMethod `
                -MockWith { $mockResponse } `
                -ParameterFilter { 
                    $uri -match "https://api.example.com/users/123e4567-e89b-12d3-a456-426614174000" -and $method -match "Put" 
                } `
                -ModuleName DataAccessModule

            $result = Set-DataAccessUser -Id $mockResponse.id `
                                         -Name $mockResponse.name `
                                         -Email $mockResponse.email `
                                         -BaseUrl "https://api.example.com"
            $result.id | Should -Be $mockResponse.id
            $result.name | Should -Be $mockResponse.name
            $result.email | Should -Be $mockResponse.email
        }
    }
}