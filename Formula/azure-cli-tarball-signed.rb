class AzureCliTarballSigned < Formula
  desc "Microsoft Azure CLI - Code-Signed & Notarized Tarball"
  homepage "https://learn.microsoft.com/cli/azure/"
  version "2.77.0"
  
  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball-signed/azure-cli-2.77.0-macos-arm64-signed.tar.gz"
  sha256 "b97867e7712f5f73dfe2d8eacbe817706724fdb585cf486c92f24e32bd49ebd6"

  # 1. Prevent Homebrew from rewriting Mach-O headers (relocation)
  # This modification is what typically invalidates Apple code signatures.
  def relocate_binaries_prefix
    false
  end

  # 2. Prevent Homebrew from stripping debug symbols or xattrs
  # Homebrew's 'clean' phase can strip binary sections or extended attributes.
  def skip_clean?(path)
    true
  end

  def install
    # 3. Use 'cp -aRp' to preserve essential extended attributes (xattrs)
    # Native Homebrew methods often strip xattrs from files over 10MB.
    prefix.mkpath
    system "cp", "-aRp", *Dir["*"], prefix
    
    # 4. Ensure the main entry point is executable
    chmod 0755, bin/"az"
  end

  test do
    # Verify the installation and ensure it can execute without gatekeeper issues
    assert_match "azure-cli", shell_output("#{bin}/az --version")
  end

  def caveats
    <<~EOS
      Azure CLI Signed Tarball has been installed!
      
      ✅ All binaries are code-signed with Apple Developer ID
      ✅ Notarized by Apple - No Gatekeeper warnings
      
      To get started:
        az login
    EOS
  end
end
