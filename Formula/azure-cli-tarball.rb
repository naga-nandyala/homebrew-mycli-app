class AzureCliTarball < Formula
  desc "Microsoft Azure CLI - Tarball Distribution"
  homepage "https://learn.microsoft.com/cli/azure/"
  version "2.77.0"
  
  on_arm do
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball/azure-cli-2.77.0-macos-arm64.tar.gz"
    sha256 "bb7ae1032e0c43a498a60517dcebefde33a857b71bc325bda8b9d64fb9516356"
  end
  
  on_intel do
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball/azure-cli-2.77.0-macos-x86_64.tar.gz"
    sha256 "a7c8aaad47d7fd15e2b7c4d8b01762081f7bf8757c2425ac7c8795657018d049"
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
