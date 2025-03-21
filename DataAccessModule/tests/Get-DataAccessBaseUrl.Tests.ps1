BeforeAll {
   Import-Module -Name "$PSScriptRoot\..\DataAccessModule.psd1","DataAccessModule" -Force 
}


Describe "Get-DataAccessBaseUrl" {
    Context "When BaseUrl is provided" {
        It "should return the provided BaseUrl" {
            $result = Get-DataAccessBaseUrl -BaseUrl "https://api.example.com"
            $result | Should -Be "https://api.example.com"
        }

        It "should trim trailing slashes from the provided BaseUrl" {
            $result = Get-DataAccessBaseUrl -BaseUrl "https://api.example.com/"
            $result | Should -Be "https://api.example.com"
        }
    }

    Context "When BaseUrl is not provided" {
        BeforeEach {
            # Clear the environment variable before each test
            Remove-Item -Path Env:DATA_LAYER_API -ErrorAction SilentlyContinue
        }

        It "should return the BaseUrl from the DATA_LAYER_API environment variable" {
            $env:DATA_LAYER_API = "https://api.example.com"
            $result = Get-DataAccessBaseUrl
            $result | Should -Be "https://api.example.com"
        }

        It "should trim trailing slashes from the BaseUrl in the DATA_LAYER_API environment variable" {
            $env:DATA_LAYER_API = "https://api.example.com/"
            $result = Get-DataAccessBaseUrl
            $result | Should -Be "https://api.example.com"
        }

        It "should throw an error if DATA_LAYER_API environment variable is not set" {
            { Get-DataAccessBaseUrl } | Should -Throw "BaseUrl not provided and DATA_LAYER_API environment variable is not set."
        }
    }

    Context "When BaseUrl is invalid" {
        It "should throw an error for an invalid BaseUrl format" {
            { Get-DataAccessBaseUrl -BaseUrl "invalid-url" } | Should -Throw
        }
    }
}