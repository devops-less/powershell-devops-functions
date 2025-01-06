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

| | |
|-|-|
| [Enable-Debug](DevOps.Helper.Functions/Public/Enable-Debug.ps1) | Enable debug log message |
| [Find-FirstFileByPattern](DevOps.Helper.Functions/Public/Find-FirstFileByPattern.ps1) | Finds a single file be pattern |
| [Install-DotNetTool](DevOps.Helper.Functions/Public/Install-DotNetTool.ps1) | runs `dotnet tool install --global xxx` |
| [Invoke-CSpell](DevOps.Helper.Functions/Public/Invoke-CSpell.ps1) | runs [cspell](https://cspell.org/)
| [Invoke-DotNet](DevOps.Helper.Functions/Public/Invoke-DotNet.ps1) | runs `dotnet restore/build/test/publish/pack` |
| [Invoke-DotNetCheckLicenses](DevOps.Helper.Functions/Public/Invoke-DotNetCheckLicenses.ps1) | runs [dotnet-project-licenses](https://github.com/tomchavakis/nuget-license) |
| [Invoke-DotNetCheckVulnerabilities](DevOps.Helper.Functions/Public/Invoke-DotNetCheckVulnerabilities.ps1) | vulnerability check using `dotnet list package --vulnerable` |
| [Invoke-DotNetEfUpdate](DevOps.Helper.Functions/Public/Invoke-DotNetEfUpdate.ps1) | runs `dotnet ef database update` |
| [Invoke-DotNetLinting](DevOps.Helper.Functions/Public/Invoke-DotNetLinting.ps1) | runs `dotnet format` checks and [csharpier](https://csharpier.com/) |
| [Invoke-EcLint](DevOps.Helper.Functions/Public/Invoke-EcLint.ps1) | runs [eclint](https://github.com/jednano/eclint) |
| [Invoke-MarkdownLint](DevOps.Helper.Functions/Public/Invoke-MarkdownLint.ps1) | runs [markdownlint](https://github.com/igorshubovych/markdownlint-cli) |
| [Invoke-NodeRestore](DevOps.Helper.Functions/Public/Invoke-NodeRestore.ps1) | runs `npm/pnpm/yarn` package restore/install |
| [Invoke-SecretLint](DevOps.Helper.Functions/Public/Invoke-SecretLint.ps1) | runs [secretlint](https://github.com/secretlint/secretlint) |
| [Write-Log](DevOps.Helper.Functions/Public/Write-Log.ps1) | write log messages |

### Private Functions

| | |
|-|-|
| [Add-TrailingSlash](DevOps.Helper.Functions/Private/Add-TrailingSlash.ps1) | Add paths trailing `/` or `\` (os deps) |
| [Get-GitFiles](DevOps.Helper.Functions/Private/Get-GitFiles.ps1) | `git ls-files` as array |
| [Assert-Condition](DevOps.Helper.Functions/Private/Assert-Condition.ps1) | test condition |
| [Invoke-ShellCommand](DevOps.Helper.Functions/Private/Invoke-ShellCommand.ps1) | exec command |
| [Test-Tool](DevOps.Helper.Functions/Private/Test-Tool.ps1) | check command/tool exists |

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
