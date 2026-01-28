cask "azure-cli-v3" do
  version "2.77.0"
  sha256 "228115e9006a13f45cae735795b98caff43c859538b3035848b6ae6e05cc5587"

  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-v3/azure-cli-2.77.0-macos-arm64-nopython-signed-notarized.tar.gz"
  name "Azure CLI"
  desc "Microsoft Azure CLI (Lightweight - uses Homebrew Python)"
  homepage "https://docs.microsoft.com/cli/azure/"

  depends_on formula: "python@3.13"

  binary "bin/az"

  zap trash: "~/.azure"
end
