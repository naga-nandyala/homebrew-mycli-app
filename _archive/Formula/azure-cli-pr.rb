class AzureCliPr < Formula
  desc "Microsoft Azure CLI - Official command-line interface"
  homepage "https://learn.microsoft.com/cli/azure/"
  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-pkg-v2/azure-cli-2.77.0-macos-arm64-notarized.pkg"
  sha256 "e0e3b352ff8f5f8d3748c0734b7ec24d055776f24238fd96dc9b0b9f5850463b"

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
