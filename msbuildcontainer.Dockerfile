FROM microsoft/windowsservercore

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-WindowsFeature NET-Framework-45-Core

#.net 4.6
RUN Invoke-WebRequest "https://download.microsoft.com/download/C/3/A/C3A5200B-D33C-47E9-9D70-2F7C65DAAD94/NDP46-KB3045557-x86-x64-AllOS-ENU.exe" -OutFile NDP46-KB3045557-x86-x64-AllOS-ENU.exe -UseBasicParsing ; \
	Start-Process -FilePath 'NDP46-KB3045557-x86-x64-AllOS-ENU.exe' -ArgumentList '/q', '/norestart' -Wait ; \
	Remove-Item NDP46-KB3045557-x86-x64-AllOS-ENU.exe

#.net 4.6.2
RUN Invoke-WebRequest "https://download.microsoft.com/download/F/9/4/F942F07D-F26F-4F30-B4E3-EBD54FABA377/NDP462-KB3151800-x86-x64-AllOS-ENU.exe" -OutFile NDP462-KB3151800-x86-x64-AllOS-ENU.exe -UseBasicParsing ; \
	Start-Process -FilePath 'NDP462-KB3151800-x86-x64-AllOS-ENU.exe' -ArgumentList '/q', '/norestart' -Wait ; \
	Remove-Item NDP462-KB3151800-x86-x64-AllOS-ENU.exe

#.net 4.5.2 targeting pack
RUN Invoke-WebRequest "https://download.microsoft.com/download/4/3/B/43B61315-B2CE-4F5B-9E32-34CCA07B2F0E/NDP452-KB2901951-x86-x64-DevPack.exe" -OutFile NDP452-KB2901951-x86-x64-DevPack.exe -UseBasicParsing ; \
	Start-Process -FilePath 'NDP452-KB2901951-x86-x64-DevPack.exe' -ArgumentList '/q', '/norestart' -Wait ; \
	Remove-Item NDP452-KB2901951-x86-x64-DevPack.exe

#.net 4.6 targeting pack
RUN Invoke-WebRequest "https://download.microsoft.com/download/8/2/F/82FF2034-83E6-4F93-900D-F88C7AD9F3EE/NDP46-TargetingPack-KB3045566.exe" -OutFile NDP46-TargetingPack-KB3045566.exe -UseBasicParsing ; \
	Start-Process -FilePath 'NDP46-TargetingPack-KB3045566.exe' -ArgumentList '/q', '/norestart' -Wait ; \
	Remove-Item NDP462-KB3151800-x86-x64-AllOS-ENU.exe

	#vs build 2017
RUN Invoke-WebRequest "https://aka.ms/vs/15/release/vs_BuildTools.exe" -OutFile vs_BuildTools.exe -UseBasicParsing ; \
	Start-Process -FilePath 'vs_BuildTools.exe' -ArgumentList '--quiet', '--norestart', '--locale en-US' -Wait ; \
	Remove-Item .\vs_BuildTools.exe ; \
	Remove-Item -Force -Recurse 'C:\Program Files (x86)\Microsoft Visual Studio\Installer'
RUN setx /M PATH $($Env:PATH + ';' + ${Env:ProgramFiles(x86)} + '\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin')



#install nuget
RUN "Invoke-WebRequest -Uri https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile "C:\windows\nuget.exe" -UseBasicParsing"
