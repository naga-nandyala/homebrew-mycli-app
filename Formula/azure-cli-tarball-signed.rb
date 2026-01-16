class AzureCliTarballSigned < Formula
  desc "Microsoft Azure CLI - Code-Signed & Notarized Tarball"
  homepage "https://learn.microsoft.com/cli/azure/"
  version "2.77.0"
  
  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball-signed/azure-cli-2.77.0-macos-arm64-signed.tar.gz"
  sha256 "b97867e7712f5f73dfe2d8eacbe817706724fdb585cf486c92f24e32bd49ebd6"

  # ✅ CORRECT: Inside stable block
  stable do
    skip_relocation!
  end

  def install
    prefix.mkpath
    system "cp", "-aRp", *Dir["*"], prefix
    chmod 0755, bin/"az"
  end

  def post_install
    # Empty - blocks Keg codesign
  end

  test do
    system "#{bin}/az", "--version"
    assert_match "azure-cli/2.77.0", shell_output("#{bin}/az --version")
  end

  def caveats
    <<~EOS
      Azure CLI Signed Tarball installed!

      ✅ Microsoft signatures preserved (UBF8T346G9)
      ✅ No Gatekeeper warnings (notarized)

      Usage: #{bin}/az login
    EOS
  end
end
