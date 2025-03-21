# Data Access API Example with Pester

This is a simple example project that demonstrates how to use Pester to test an API. The API creates information in memory, which is lost once the session ends. The design of this project is intended to be educational and is not meant for production use.

## Overview

This project includes several PowerShell cmdlets to interact with a data access API. The cmdlets allow you to create, retrieve, update, and delete user information. The API stores data in memory, so all data is lost when the session ends.

## Cmdlets

- `Get-DataAccessBaseUrl`: Retrieves the base URL of the data access API.
- `Get-DataAccessUser`: Retrieves user information from the data access API.
- `New-DataAccessUser`: Creates a new user in the data access API.
- `Set-DataAccessUser`: Updates an existing user in the data access API.
- `Remove-DataAccessUser`: Removes an existing user from the data access API.

## Running Tests with Pester

Pester is a testing framework for PowerShell. To run the tests for this project, follow these steps:

1. Install Pester if you haven't already:

    ```powershell
    Install-PSResource -Name Pester
    ```

2. Navigate to the project directory:

    ```powershell
    cd .\DataAccessLayer
    dotnet run --project DataAccessLayerAPI
    ```

3. Run the Pester tests:

    ```powershell
    cd .\DataAccessModule
    ## if you are executing using the terminal, either you make the folder part of the PSModulePath 
    ## or add it when executing the pester
    ## see https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath
    ## this command will add the directory to the path
    ## no worries only affects the current terminal session
    ## if you are using linux change the ; for a :
    $env:PSModulePath = $env:PSModulePath + ";" + (Get-Item .).FullName
    Invoke-Pester
    ```

This will execute all the tests defined in the `tests` directory and provide a summary of the results.

## License

This project is licensed under the MIT License. This means you are free to use, modify, and distribute this code, but you do so at your own risk. The author is not responsible for any issues that may arise from using this code. By using this code, you agree that you are doing so at your own risk.

## MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Disclaimer

This project is intended for educational purposes only. It is not designed for production use. Use this code at your own risk. The author is not responsible for any issues that may arise from using this code.
