class AzureCliZipSigned < Formula
  desc "Microsoft Azure CLI - Code-Signed & Notarized ZIP"
  homepage "https://learn.microsoft.com/cli/azure/"
  version "2.77.0"
  
  on_arm do
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-zip-tarball/azure-cli-2.77.0-macos-arm64-notarized.zip"
    sha256 "ebc2f77921ec3defe5a06bb670537716b88b59a84ae3a7271799d7cbc1b28354"
  end
  
  on_intel do
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-zip-tarball/azure-cli-2.77.0-macos-x86_64-notarized.zip"
    sha256 "daf9b5ffeade38c3d54654926080b6c2d87cdb8f428e6b85144343e6db9fece1"
  end
  
  def install
    # Install signed and notarized ZIP
    prefix.install Dir["*"]
    chmod 0755, bin/"az"
  end
  
  test do
    system "#{bin}/az", "--version"
  end
  
  def caveats
    <<~EOS
      Azure CLI Signed ZIP has been installed!
      
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
