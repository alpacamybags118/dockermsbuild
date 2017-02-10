# dockermsbuild
Docker container to build .NET applications

This is a work in progress. The goal is to be able to build .NET applications within a docker container.

This is the general workflow:

1. Container is created from build environment image, which contains msbuild, nuget, and any other tools needed to build application. It will take in the source code for the application you wish to build
2. Once the solution is built, the resulting compiled assemblies will be copied from the container to whereever you wish (local machine, file share, etc.)

To use this, follow the steps below:

1. Get Docker for Windows (you'll have to get the beta version currently as Windows containers are still not in the main release)
2. In powershell, run <code>docker build -f buildcontainer -t msbuildtest .</code> This will build the build environment
3. Open the build dockerfile, and specify the solution you wish to build. Make sure the source code for that project is in the same directory as the dockerfile
4. Run <code>docker build -f build -t buildsolution .</code> to build the image which will be ran in a container to build the solution
5. Run <code>docker run buildsolution</code> 

Currently, you must hard-code the solution you want to build into the "build" dockerfile, the build the image. You will then have to rebuild the buildsolution image and run it to build the new solution. This is obviously not what the final product will do, but this is a prototype. You must also change the project file(s) in your application to target so that the VSToolsPath is the following:

<code><VSToolsPath Condition="'$(VSToolsPath)' == ''">$(MSBuildExtensionsPath32)/$(VisualStudioVersion)</VSToolsPath></code>

Things to do:
<ul>
  <li> Change image to use chocolatey package managmennt to get needed tools
  <li> Figure out why a Visual Studio path is not in the MSBuild directory
  <li> Change the build image to take in a solution as an argument
  <li> Extract the compiled assemblies out of the container and move them to somewhere (probably just local machine for the time being)
 </ul>
