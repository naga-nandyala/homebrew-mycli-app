cask "azure-cli-v3" do
  version "2.77.0"

  on_arm do
    sha256 "8798038e702d1f43f18b133c33ac2a8bdfa9984cd1e24bacef06407b08319c73"
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-v3/azure-cli-2.77.0-macos-arm64-nopython-signed-notarized.tar.gz"
  end

  on_intel do
    sha256 "75b7937176e95ae6a910083d5940076a715e424a4fc393edfa60390d38afe779"
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-v3/azure-cli-2.77.0-macos-x86_64-nopython-signed-notarized.tar.gz"
  end

  name "Azure CLI"
  desc "Microsoft Azure CLI (Lightweight - uses Homebrew Python)"
  homepage "https://docs.microsoft.com/cli/azure/"

  depends_on formula: "python@3.13"

  binary "bin/az"

  zap trash: "~/.azure"
end
