class AzureCliTarballSignedNotarizedV2 < Formula
  desc "Microsoft Azure CLI - Code-Signed and Notarized Tarball (v2)"
  homepage "https://learn.microsoft.com/cli/azure/"
  version "2.77.0"

  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball-v2/azure-cli-2.77.0-macos-arm64-signed-notarized.tar.gz"
  sha256 "5acf2277dbbdd046364e899d14f0ca4a9c2a25c5d76295d3dd472200e197dc61"

  def install
    prefix.mkpath
    system "cp", "-aRp", *Dir["*"], prefix
    chmod 0755, bin/"az"
  end

  test do
    system "#{bin}/az", "--version"
  end
end
