class AzureCliTarballSigned < Formula
  desc "Microsoft Azure CLI - Code-Signed & Notarized Tarball"
  homepage "https://learn.microsoft.com/cli/azure/"
  version "2.77.0"
  
  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball-signed/azure-cli-2.77.0-macos-arm64-signed.tar.gz"
  sha256 "b97867e7712f5f73dfe2d8eacbe817706724fdb585cf486c92f24e32bd49ebd6"
  
  def install
    
    # Use cp -aRp to preserve code signatures (embedded in Mach-O binaries)
    prefix.mkpath
    system "cp", "-aRp", *Dir["*"], prefix
    chmod 0755, bin/"az"
    
    
  end
  
  
  test do
 
    
    system "#{bin}/az", "--version"
  end
  
  def caveats
    <<~EOS
      Azure CLI Signed Tarball has been installed!  --- xxxxxxxxx updated xxxxxxx
      
      ✅ All binaries are code-signed with Apple Developer ID
      ✅ Notarized by Apple - No Gatekeeper warnings
      
      Installation Details:
        • Executable: #{bin}/az
        • Runtime: #{libexec}/
        • Python: Bundled Python runtime
      
      This is a fully code-signed and notarized distribution.
      No quarantine issues with browser downloads!
      
      To get started:
        az login
        az account list
    EOS
  end
end
