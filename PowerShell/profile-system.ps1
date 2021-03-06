# Friendly PowerShell Execution Policy
# Set-ExecutionPolicy Unrestricted


# Use this snippet if corporate domain policies hijack your $HOME folder...
# Remove-Variable -Force HOME
# Set-Variable HOME "C:\Users\Keith Beckman"


# Downloads all system scripts and dependencies required by PowerShell environment...
# $githubPath: sysGitHub target dir, installation directory
Function Setup-Dependencies([string]$githubPath)
{
	if (!(Test-Path $githubPath)) { mkdir $githubPath }

	cd $githubPath

	git clone 'https://github.com/JeremySkinner/posh-hg.git'
	git clone 'https://github.com/dahlbyk/posh-git.git'
	git clone 'https://kbeckman@github.com/kbeckman/Scripts-Settings.git'
}


# START PROFILE SCRIPT

# Set necessary command line environment variables...
# [Ruby 1.9.3, Git, TortoiseHg, DiffMerge, NuGet, VirtualBox, Sysinternals Suite, 7-7ip, OpenSSL,
# MakeCert.exe]
$requiredPaths = @( ";C:\Ruby193\bin", 					
					";C:\Program Files (x86)\Git\cmd",
					";C:\Program Files\TortoiseHg",
					";C:\Program Files\SourceGear\Common\DiffMerge",
					";C:\Program Files (x86)\NuGet",
					";C:\Program Files\Oracle\VirtualBox", 
					";C:\Program Files (x86)\Sysinternals Suite", 
					";C:\Program Files\7-Zip",
					";C:\OpenSSL-Win32\bin",
					";C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\bin" )
					
foreach ($path in $requiredPaths)
{
	if (!($env:Path.Contains($path))) { $env:Path += $path }
}


# Setup local GitHub dependencies...
$sysGitHub 	= Join-Path $HOME "GitHub"
$sysScripts = Join-Path $sysGitHub "Scripts-Settings\PowerShell\FuncLib"	
if (!(Test-Path $sysGitHub )) 
{ 
	Setup-Dependencies $sysGitHub 
	Get-ChildItem $sysScripts -filter "*.ps1" | 
		ForEach-Object -Process { . (Join-Path $sysScripts $_.Name) }
	Git-Setup
}
else 
{ 
	Get-ChildItem $sysScripts -filter "*.ps1" | 
		ForEach-Object -Process { . (Join-Path $sysScripts $_.Name) } 
}


Setup-PowerShell-Console


# Load Posh-Hg/Git libraries...
$poshHgPath		= Join-Path $sysGitHub "posh-hg\profile.example.ps1"
$poshGitPath	= Join-Path $sysGitHub "posh-git\profile.example.ps1"
if (Test-Path $poshHgPath) { . $poshHgPath }
if (Test-Path $poshHgPath) { . $poshGitPath }


# Load developer profile script...
$devProfilePath = Join-Path $sysGitHub "Scripts-Settings\PowerShell\profile-developer.ps1"	
. $devProfilePath


cd $HOME

