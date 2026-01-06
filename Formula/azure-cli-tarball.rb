class AzureCliTarball < Formula
  desc "Microsoft Azure CLI - Tarball Distribution"
  homepage "https://learn.microsoft.com/cli/azure/"
  version "2.77.0"
  
  on_arm do
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball/azure-cli-2.77.0-macos-arm64.tar.gz"
    sha256 "d18b3f231fc9fb2fef01611c1e47b334289d8f76f6e9e82e7e0577c146cb20dc"
  end
  
  on_intel do
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball/azure-cli-2.77.0-macos-x86_64.tar.gz"
    sha256 "a4fdd67fbd0bfad958768b435a2e01424e2c29a7bdc4344caee86014c5d2270d"
  end
  
  def install
    # Extract tarball structure:
    #   bin/az (wrapper script)
    #   libexec/az/ (Python runtime and libraries)
    
    # Install to prefix
    prefix.install Dir["*"]
    
    # Ensure az wrapper is executable
    chmod 0755, bin/"az"
  end
  
  test do
    system "#{bin}/az", "--version"
  end
  
  def caveats
    <<~EOS
      Azure CLI Tarball has been installed!
      
      Installation Details:
        • Executable: #{bin}/az
        • Runtime: #{prefix}/libexec/az/
        • Python: Bundled Python 3.13.11
      
      This is a self-contained tarball with all dependencies.
      No additional system Python or packages required!
      
      To get started:
        az login
        az account list
      
      Documentation:
        https://learn.microsoft.com/cli/azure/
    EOS
  end
end
