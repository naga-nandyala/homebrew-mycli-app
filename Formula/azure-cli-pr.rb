class AzureCliPr < Formula
  desc "Microsoft Azure CLI - Official command-line interface"
  homepage "https://learn.microsoft.com/cli/azure/"
  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.0.0/azure-cli-2.0.0-macos-arm64-notarized.pkg"
  sha256 "75672bdbfd7b90aebe56900ebf5760589003800b885521f34b396b560bf536ba"

  def install
    # Extract the PKG contents to get the payload
    system "pkgutil", "--expand", cached_download, buildpath/"azure-cli.unpkg"
    payload = Dir[buildpath/"azure-cli.unpkg"/"*.pkg"].first
    
    # Extract the Payload archive to the Cellar prefix
    system "tar", "-xzf", "#{payload}/Payload", "-C", prefix
    
    # The PKG installs to absolute paths, so files are at:
    #   prefix/bin/az (wrapper script)
    #   prefix/microsoft/azure-cli/ (Python venv)
    # Homebrew bin.install will create symlinks automatically from prefix/bin/
    
    # Ensure the wrapper script is executable
    chmod 0755, prefix/"bin/az"
  end

  test do
    system "#{bin}/az", "--version"
  end
end
