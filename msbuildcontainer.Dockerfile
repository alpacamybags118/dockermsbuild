FROM microsoft/windowsservercore

COPY solutiontobuild C:\\Build

SHELL ["powershell"]

#install chocolatey and allow scripts to run without confirmation
RUN "iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex"
RUN "choco feature enable -n=allowGlobalConfirmation"

#install msbuild
RUN "choco install microsoft-build-tools"
