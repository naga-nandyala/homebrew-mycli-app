cask "azure-cli-v3" do
  version "2.77.0"

  on_arm do
    sha256 "c6e45e7b675d299c03b21a6b2436fb8bcb880202a634fe4bc4e6c5f8eb2090b1"
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-v3/azure-cli-2.77.0-macos-arm64-nopython-signed-notarized.tar.gz"
  end

  on_intel do
    sha256 "298de64a4d0c581b0cf74e651e9d9c432d249bfac484aa9235c9ce1a7c1a3d64"
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-v3/azure-cli-2.77.0-macos-x86_64-nopython-signed-notarized.tar.gz"
  end

  name "Azure CLI"
  desc "Microsoft Azure CLI (Lightweight - uses Homebrew Python)"
  homepage "https://docs.microsoft.com/cli/azure/"

  depends_on formula: "python@3.13"

  binary "bin/az"

  zap trash: "~/.azure"
end
