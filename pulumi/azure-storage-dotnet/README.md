# Azure Storage using Pulumi and C# DotNet

A simple demo of using .net 8 SDK and pulumi to create an Azure Storage Account

## Relevant Links
* [Pulumi Getting Started for C# .NET](https://www.pulumi.com/docs/languages-sdks/dotnet/)
* [dot net sdk releases](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)

## Notes related to env0
* env0 uses an alpine image - so we will be downloading and using the [x64 Alpine binary](https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-8.0.101-linux-x64-alpine-binaries)
* Pulumi needs some credentials configured to access AWS - we will be configuring the credentials using some pulumi config commands.  see env0.yaml for more details.
* We will need a Pulumi Token - you can retrieve one from going to account.

## Misc notes for setting up pulumi | HowTo Setup Pulumi for .net the first time
1. Create an empty folder (e.g. s3-dotnet)
2. `cd s3-dotnet`
3. `pulumi new azure-csharp`
3b. update the csproj "<TargetFramework>net8.0</TargetFramework>"
4. test it with `pulumi up` (this will also trigger the pulumi token configuration if you haven't done it yet)
5. Add an `env0.yaml` for env0 to setup and install dotnet ** NOTE: if you're using env0 self-hosted agent, you could extend the image to include the dotnet sdk.

env0.yaml example:  # with notes
```
version: 2

deploy: &pulumi
  steps:
    setupVariables:
      after:
        - name: Setup dotnet  
          run: |
            if [[ ! -e /opt/dotnet ]]; then
              wget -nc https://download.visualstudio.microsoft.com/download/pr/f75f8192-785e-4199-8643-6ee8a87dca34/6bd0c5e0da66cc807be5b76e18092750/dotnet-sdk-8.0.101-linux-musl-x64.tar.gz
              tar -zxf dotnet-sdk-8.0.101-linux-musl-x64.tar.gz -C /opt  # /opt in env0 is in the PATH so we can save binaries into this folder
            fi
            dotnet --info
destroy: *pulumi
```

### Potential Further Reading
* https://www.pulumi.com/docs/concepts/config/#provider-configuration-options
