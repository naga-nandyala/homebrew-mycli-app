class AzureCliTarballSigned < Formula
  desc "Microsoft Azure CLI - Code-Signed & Notarized Tarball"
  homepage "https://learn.microsoft.com/cli/azure/"
  version "2.77.0"
  
  on_arm do
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball-signed/azure-cli-2.77.0-macos-arm64-notarized.tar.gz"
    sha256 "e18d8aee577ee4f6d592f3c1ee36b473483f3540f840a9cbc9ad58de3e173644"
  end
  
  on_intel do
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball-signed/azure-cli-2.77.0-macos-x86_64-notarized.tar.gz"
    sha256 "df3877d99a78c70ec1d9053af122f512db51275bbdf05925de4cd93b2f7af8bf"
  end
  
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
