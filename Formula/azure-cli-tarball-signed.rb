class AzureCliTarballSigned < Formula
  desc "Microsoft Azure CLI - Code-Signed Tarball"
  homepage "https://learn.microsoft.com/cli/azure/"
  version "2.77.0"
  
  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball-signed/azure-cli-2.77.0-macos-arm64-signed.tar.gz"
  sha256 "b97867e7712f5f73dfe2d8eacbe817706724fdb585cf486c92f24e32bd49ebd6"
  
  # Skip all Homebrew post-processing to preserve code signatures
  skip_clean :all
  
  # Prevent Homebrew from stripping binaries
  def post_install
    # No-op: prevent any post-install modifications 
  end
  
  def install
    # cp with -a (archive) preserves extended attributes including code signatures
    prefix.mkpath
    system "cp", "-aRp", *Dir["*"], prefix
    chmod 0755, bin/"az"
  end
  
  test do
    system "#{bin}/az", "--version"
  end
  
  def caveats
    <<~EOS
      Azure CLI Signed Tarball has been installed!
      
      ✅ Testing signature preservation with cp -aRp
      
      Installation Details:
        • Executable: #{bin}/az
        • Runtime: #{prefix}/libexec/
        • Python: Bundled Python runtime
      
      To get started:
        az login
        az account list
    EOS
  end
end
