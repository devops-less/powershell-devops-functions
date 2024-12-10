# DevOps.Helper.Functions

A set of functions to help with DevOps tasks like building applications and running tools.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Functions](#functions)
- [License](#license)

## Installation

To install the module, run the following command in PowerShell:

```powershell
Import-Module -Name DevOps.Helper.Functions
```

## Usage

To use the functions provided by this module, simply call them in your PowerShell scripts. For example:

```powershell
Invoke-DotNetCheckLicenses -Folder "C:\MyProject" -Print
```

## Functions

### Public Functions

- [Enable-Debug](Public/Enable-Debug.ps1)
- [Find-FirstFileByPattern](Public/Find-FirstFileByPattern.ps1)
- [Install-DotNetTool](Public/Install-DotNetTool.ps1)
- [Invoke-CSpell](Public/Invoke-CSpell.ps1)
- [Invoke-DotNet](Public/Invoke-DotNet.ps1)
- [Invoke-DotNetCheckLicenses](Public/Invoke-DotNetCheckLicenses.ps1)
- [Invoke-DotNetCheckVulnerabilities](Public/Invoke-DotNetCheckVulnerabilities.ps1)
- [Invoke-DotNetEfUpdate](Public/Invoke-DotNetEfUpdate.ps1)
- [Invoke-DotNetLinting](Public/Invoke-DotNetLinting.ps1)
- [Invoke-MarkdownLint](Public/Invoke-MarkdownLint.ps1)
- [Invoke-NodeRestore](Public/Invoke-NodeRestore.ps1)
- [Invoke-SecretLint](Public/Invoke-SecretLint.ps1)
- [Write-Log](Public/Write-Log.ps1)

### Private Functions

- [Add-TrailingSlash](Private/Add-TrailingSlash.ps1)
- [Assert-Condition](Private/Assert-Condition.ps1)
- [Invoke-ShellCommand](Private/Invoke-ShellCommand.ps1)
- [Test-Tool](Private/Test-Tool.ps1)

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
