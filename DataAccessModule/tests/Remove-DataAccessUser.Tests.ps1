BeforeAll {
    Import-Module -Name "$PSScriptRoot\..\DataAccessModule.psd1","DataAccessModule" -Force 
}

Describe "Remove-DataAccessUser" {
    Context "When Id is provided" {
        It "should remove the user with the provided Id" {
            $mockResponse = @{
                id = "123e4567-e89b-12d3-a456-426614174000"
            }
            Mock -CommandName Invoke-RestMethod `
                -MockWith { $mockResponse } `
                -ParameterFilter { 
                    $uri -match "https://api.example.com/users/123e4567-e89b-12d3-a456-426614174000" `
                    -and $method -match "Delete" 
                } `
                -ModuleName DataAccessModule

            Remove-DataAccessUser -Id $mockResponse.id `
                                  -BaseUrl "https://api.example.com"
            Should -Invoke Invoke-RestMethod `
                    -Exactly -Times 1 `
                    -ModuleName DataAccessModule # this parameter is important, if it is not used it will fail

        }
    }

}