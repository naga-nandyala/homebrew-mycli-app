class AzureCliPr < Formula
  desc "Microsoft Azure CLI - Official command-line interface"
  homepage "https://learn.microsoft.com/cli/azure/"
  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0/azure-cli-2.77.0-macos-arm64-notarized.pkg"
  sha256 "52dd232d49c890f06479640fb1f3dc78ee1dd1b04fe1636e3015524b79e95b0b"

  def install
    system "pkgutil", "--expand", cached_download, buildpath/"azure-cli.unpkg"
    payload = Dir[buildpath/"azure-cli.unpkg"/"*.pkg"].first
    system "tar", "-xzf", "#{payload}/Payload", "-C", prefix
    bin.install_symlink prefix/"usr/local/bin/az"
  end

  test do
    system "#{bin}/az", "--version"
  end
end
