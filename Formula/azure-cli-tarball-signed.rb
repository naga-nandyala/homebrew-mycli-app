class AzureCliTarballSigned < Formula
  desc "Microsoft Azure CLI - Code-Signed & Notarized Tarball"
  homepage "https://learn.microsoft.com/cli/azure/"
  version "2.77.0"
  
  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball-signed/azure-cli-2.77.0-macos-arm64-signed.tar.gz"
  sha256 "31ab675e2fa5246979a7ba9897556b47f48323a7d3185bdf034cad76375cf8e4"
  
  def install
    # Install signed and notarized tarball
    prefix.install Dir["*"]
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
        • Runtime: #{prefix}/libexec/
        • Python: Bundled Python runtime
      
      This is a fully code-signed and notarized distribution.
      No quarantine issues with browser downloads!
      
      To get started:
        az login
        az account list
    EOS
  end
end
