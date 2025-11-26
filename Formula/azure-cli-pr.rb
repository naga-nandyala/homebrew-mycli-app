class AzureCliPr < Formula
  desc "Microsoft Azure CLI - Official command-line interface"
  homepage "https://learn.microsoft.com/cli/azure/"
  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.0.0/azure-cli-2.0.0-macos-arm64-notarized.pkg"
  sha256 "ffaed14113201ec91594e051a2471cdedb4ebd3deb5054b2988b0e8d2fd77ced"

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
