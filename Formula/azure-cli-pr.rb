class AzureCliPr < Formula
  desc "Microsoft Azure CLI - Official command-line interface"
  homepage "https://learn.microsoft.com/cli/azure/"
  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.0.0/azure-cli-2.0.0-macos-arm64-notarized.pkg"
  sha256 "0c0ccfc9e0599ad9090602c707dbef485d71c2c2cd1d5e996e414fb10ef232b4"
  version "2.0.0"

  bottle :unneeded

  def install
    system "pkgutil", "--expand", cached_download, buildpath/"azure-cli.unpkg"
    payload = Dir[buildpath/"azure-cli.unpkg"/"*.pkg"].first
    system "tar", "-xzf", "#{payload}/Payload", "-C", prefix
    bin.install_symlink prefix/"usr/local/bin/az"
  end

  def caveats
    "Azure CLI installed. Run 'az --version' to verify."
  end

  test do
    system "#{bin}/az", "--version"
  end
end
