cask "azure-cli-v3" do
  version "2.77.0"
  sha256 "5a759ffa41974dcb44dd63e04a48905473a83557b4cf40b1a97dd7611d67d2b1"

  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-v3/azure-cli-2.77.0-macos-arm64-nopython.tar.gz"
  name "Azure CLI"
  desc "Microsoft Azure CLI (Lightweight - uses Homebrew Python)"
  homepage "https://docs.microsoft.com/cli/azure/"

  depends_on formula: "python@3.13"

  binary "bin/az"

  zap trash: "~/.azure"
end
