class AzureCliTarballSigned < Formula
  desc "Microsoft Azure CLI - Code-Signed Tarball"
  homepage "https://learn.microsoft.com/cli/azure/"
  version "2.77.0"
  
  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball-signed/azure-cli-2.77.0-macos-arm64-signed.tar.gz"
  sha256 "b97867e7712f5f73dfe2d8eacbe817706724fdb585cf486c92f24e32bd49ebd6"
  
  # Critical: Skip all Homebrew post-processing that strips code signatures
  skip_clean :all
  
  def install
    # Use system cp with -aRp to preserve extended attributes (code signatures)
    # Ruby's FileUtils strips xattrs from files >10MB, so we must use cp command directly
    libexec.mkpath
    system "cp", "-aRp", "bin", "libexec", libexec
    bin.install_symlink libexec/"bin/az"
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
