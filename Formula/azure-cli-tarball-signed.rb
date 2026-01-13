class AzureCliTarballSigned < Formula
  desc "Microsoft Azure CLI - Code-Signed & Notarized Tarball"
  homepage "https://learn.microsoft.com/cli/azure/"
  version "2.77.0"
  
  # ARM64 (Apple Silicon) only - Intel Macs can use Rosetta 2
  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball-signed/azure-cli-2.77.0-macos-arm64-notarized.tar.gz"
  sha256 "b8b14fb044b2998f23813dd3c2c4100e0b841c47a753509e6c2cf31d6e9ba169"
  
  def install
    # Install signed and notarized tarball
    prefix.install Dir["*"]
    chmod 0755, bin/"az"
  end
  
  test do
    system "#{bin}/az", "--version"
  end
  
  def caveats
    <<~EOS
      Azure CLI Signed Tarball has been installed!
      
      ✅ All binaries are code-signed with Apple Developer ID
      ✅ Notarized by Apple - No Gatekeeper warnings
      
      Installation Details:
        • Executable: #{bin}/az
        • Runtime: #{prefix}/libexec/az/
        • Python: Bundled Python 3.13.11
      
      This is a fully code-signed and notarized distribution.
      No quarantine issues with browser downloads!
      
      To get started:
        az login
        az account list
    EOS
  end
end
