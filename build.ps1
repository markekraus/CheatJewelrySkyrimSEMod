<#
.SYNOPSIS
    Pulls in assets from the skyrim Data Folder to create the 7z Skyrim SE mod package.
.DESCRIPTION
    Pulls in assets from the skyrim Data Folder to create the 7z Skyrim SE mod package.
.PARAMETER ConfigFile
    The path to the buildConfig.json used to build this mod
.PARAMETER SkipReadme
    Skips generating the txt and bbcode readme from MD.
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    None
.OUTPUTS
    None
.NOTES
    Copyright 2021 Mark E. Kraus
#>
[CmdletBinding()]
param (
    [Parameter(
        Position=0,
        ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    $ConfigFile =
    $(
        if (![string]::IsNullOrWhitespace($PSScriptRoot)) {
            Join-Path $PSScriptRoot "buildConfig.json"
        }
        else {
            Join-Path $pwd.Path "buildConfig.json"
        }
    ),
    [Parameter()]
    [switch]
    $SkipReadme
)
$StartTime = [datetime]::UtcNow
Write-Host ("Build started {0} UTC" -f $StartTime)
Write-Host " "

$7zFiles = [System.Collections.Generic.List[string]]::New()

$BasePath = Split-Path $ConfigFile
Push-Location $BasePath

$FomodBasePath = Join-Path $BasePath "fomod"
$FomodInfoFile = Join-Path $FomodBasePath "info.xml"
$FomodModuleConfigFile = Join-Path $FomodBasePath "ModuleConfig.xml"

$Config = Get-Content -Path $ConfigFile | ConvertFrom-Json -Depth 10
$ModInfo = $Config.ModInfo

$SkyrimDataPath = $Config.SkyrimSE.DataPath
$SkyrimScriptPath = Join-Path $SkyrimDataPath 'scripts'
$SkyrimScriptSourcePath = Join-Path $SkyrimDataPath -ChildPath 'source' -AdditionalChildPath 'scripts'

$OutputScriptPath = Join-Path $BasePath 'scripts'
$OutputScriptSourcePath = Join-Path $BasePath -ChildPath 'source' -AdditionalChildPath 'scripts'

Write-Host @"

BasePath:               $BasePath
OutputScriptPath:       $OutputScriptPath
OutputScriptSourcePath: $OutputScriptSourcePath
FomodBasePath:          $FomodBasePath
FomodInfoFile:          $FomodInfoFile
FomodModuleConfigFile:  $FomodModuleConfigFile
SkyrimDataPath:         $SkyrimDataPath
SkyrimScriptPath:       $SkyrimScriptPath
SkyrimScriptSourcePath: $SkyrimScriptSourcePath

"@

$null = New-Item -ItemType Directory -Path $OutputScriptPath -Force
$null = New-Item -ItemType Directory -Path $OutputScriptSourcePath -Force

$PluginXmlTemplate = @'

                        <plugin name="{0}">
                            <description>{1}</description>
                            <image path="{2}" />
                            <files>
                                <file source="{3}" destination="{3}" priority="0" />
                            </files>
                            <typeDescriptor>
                                <type name="Optional"/>
                            </typeDescriptor>
                        </plugin>
'@

$PluginPartXml = ""
$First = $true
foreach ($Plugin in $Config.Plugins) {
    $PluginPath = Join-Path $SkyrimDataPath $Plugin
    if(Test-Path -Path $PluginPath){
        $7zFiles.Add($Plugin)
        Write-Host "Copying $PluginPath"
        Copy-Item -Path $PluginPath -Destination $BasePath -Force
        if ($First) {
            $PluginName = $Plugin + " (default)"
        }
        else {
            $PluginName = $Plugin
        }
        $PluginPartXml = $PluginPartXml + ($PluginXmlTemplate -f @(
            $PluginName
            $PluginName + ". " + $ModInfo.Description
            $ModInfo.Logo
            $Plugin
        ))
    }
}

$ScriptXmlTemplate = @'

                                <file source="scripts\{0}" destination="scripts\{0}" priority="0" />
'@
$ScriptSourceXmlTemplate = @'

                                <file source="source\scripts\{0}" destination="source\scripts\{0}" priority="0" />
'@
$ScriptsXmlPart=""
foreach ($papyrusScript in $Config.Scripts) {
    $pexFile = $papyrusScript + ".pex"
    $pscFile = $papyrusScript + ".psc"
    $PapyrusScriptPath = Join-Path $SkyrimScriptPath $pexFile
    $PapyrusScriptSourcePath = Join-Path $SkyrimScriptSourcePath $pscFile
    if(Test-Path -Path $PapyrusScriptPath){
        $7zFiles.Add("scripts\" + $pexFile)
        Write-Host "Copying $PapyrusScriptPath"
        Copy-Item -Path $PapyrusScriptPath -Destination $OutputScriptPath -Force
        $ScriptsXmlPart += $ScriptXmlTemplate -f $pexFile
    }
    else {
        Write-Error "Unable to find script '$PapyrusScriptPath'"
    }
    if(Test-Path -Path $PapyrusScriptSourcePath){
        $7zFiles.Add("source\scripts\" + $pscFile)
        Write-Host "Copying $PapyrusScriptSourcePath"
        Copy-Item -Path $PapyrusScriptSourcePath -Destination $OutputScriptSourcePath -Force
        $ScriptsXmlPart += $ScriptSourceXmlTemplate -f $pscFile
    }
    else {
        Write-Warning "Unable to find script source '$PapyrusScriptSourcePath'"
    }
}

$InfoXml = @'
<fomod>
    <Name>{0}</Name>
    <Author>{1}</Author>
    <Version>{2}</Version>
    <Website>{3}</Website>
    <Description>{4}</Description>
    <Groups>
        <element>{5}</element>
    </Groups>
</fomod>
'@ -f @(
    $ModInfo.Name
    $ModInfo.Author
    $ModInfo.Version
    $ModInfo.Website
    $ModInfo.Description
    $ModInfo.Category
)

$Null = New-Item -ItemType Directory -Path $FomodBasePath -Force
$InfoXml | Set-Content -Encoding utf8NoBOM -Path $FomodInfoFile



$ModuleConfigXML = @'
<!-- Created with build.ps1 by Mark E. Kraus --> 
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://qconsulting.ca/fo3/ModConfig5.0.xsd"> 
    <moduleName>{0}</moduleName> 
    <installSteps order="Explicit"> 
        <installStep name="Install"> 
            <optionalFileGroups order="Explicit"> 
                <group name="Main" type="SelectExactlyOne"> 
                    <plugins order="Explicit">{1}
                    </plugins> 
                </group> 
                <group name="Scripts" type="SelectExactlyOne"> 
                    <plugins order="Explicit"> 
                        <plugin name="Install Scripts"> 
                            <description>Installs the compiled scripts and their sources.</description>
                            <image path="{2}" />
                            <files>{3}
                            </files>
                            <typeDescriptor> 
                                <type name="Optional"/> 
                            </typeDescriptor> 
                        </plugin> 
                    </plugins> 
                </group> 
            </optionalFileGroups> 
        </installStep> 
    </installSteps> 
</config>
'@ -f @(
    $ModInfo.Name
    $PluginPartXml
    $ModInfo.Logo
    $ScriptsXmlPart
)

$ModuleConfigXML | Set-Content -Encoding utf8NoBOM -Path $FomodModuleConfigFile

$bbcode = [System.Text.StringBuilder]::New()
$inList = $false
if(!$SkipReadme){
    Copy-Item ".\README.md" "README.txt"
    $7zFiles.Add("README.txt")
    foreach ($Line in (Get-Content "README.md")) {
        if ($Line -match '^#[^#]') {
            $Line = $Line -replace '^# ','[size=6]'
            $Line = $Line + '[/size]'
        }
        elseif ($Line -match '^##[^#]') {
            $Line = $Line -replace '^## ','[size=5]'
            $Line = $Line + '[/size]'
        }
        elseif ($Line -match '^#') {
            $Line = $Line -replace '^#* ','[size=4]'
            $Line = $Line + '[/size]'
        }
        if ($inList -and $Line -notmatch '^\* ') {
            $inList = $false
            $null =  $bbcode.AppendLine('[/list]')
        }
        if (!$inList -and $Line -match '^\* ') {
            $inList = $true
            $null =  $bbcode.AppendLine('[list]')
        }
        if($inList -and $Line -match '^\* ') {
            $Line = $Line -replace '^\* ', '[*]'
        }
        $Line = $Line -replace '!\[[^)]*\)'
        $Line = $Line -replace '\[([^\]]*)\]\(([^)]*)\)', '[url=$2]$1[/url]'
        $Line = $Line -replace '`([^`]*)`', '[font=Courier New]$1[/font]'
        $null = $bbcode.AppendLine($Line)
    }
    $bbcode.ToString() | Set-Content -Encoding utf8NoBOM README.bbcode -NoNewline
}

if(Test-Path 'LICENSE'){
    $7zFiles.Add('LICENSE')
}

if(Test-Path $ModInfo.Logo){
    $7zFiles.Add($ModInfo.logo)
}
$7zFiles.Add("fomod\info.xml")
$7zFiles.Add("fomod\ModuleConfig.xml")

Write-Host ""
Write-Host "Archive files:"
foreach ($file in $7zFiles) {
    Write-Host $file
}

Remove-Item -Path $Config.PackageName -Force -ErrorAction SilentlyContinue
7za.exe a -t7z $Config.PackageName $7zFiles

Pop-Location
$EndTime = [datetime]::UtcNow
$Elapsed = ($EndTime - $StartTime).TotalSeconds
Write-Host @"

Build ended $EndTime UTC
$Elapsed (s)
"@