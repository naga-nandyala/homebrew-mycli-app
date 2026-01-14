class AzureCliZipSigned < Formula
  desc "Microsoft Azure CLI - Code-Signed & Notarized ZIP (ARM64 only)"
  homepage "https://learn.microsoft.com/cli/azure/"
  version "2.77.0"
  

  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-zip-tarball/azure-cli-2.77.0-macos-arm64-notarized.zip"
  sha256 "4fbb35787f77d763534cbcd8a28ea4d3789b96ce1cd645e7c60fa4dae20a94dd"

  
  def install
    # ZIP structure matches tarball: bin/az -> symlink to ../libexec/bin/az
    # Install everything as-is with symlinks preserved
    prefix.install Dir["*"]
    
    # Ensure executable permissions
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
