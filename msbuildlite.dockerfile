# escape=`

FROM microsoft/windowsservercore

RUN mkdir c:\temp

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ExecutionPolicy unrestricted -force

RUN powershell wget https://aka.ms/vs/15/release/vs_buildtools.exe -outfile c:\temp\vs_BuildTools.exe
RUN c:\temp\vs_BuildTools.exe --quiet --norestart --wait`
 --includeRecommended`
 --includeOptional`
 --add Microsoft.VisualStudio.Workload.MSBuildTools`
 --add Microsoft.VisualStudio.Workload.VCTools`
 --add Microsoft.VisualStudio.Workload.WebBuildTools
