cask "azure-cli-v3" do
  version "2.77.0"

  on_arm do
    sha256 "fd68bf63c38234f794b384490734cf6c503f8266856dea3b8436ce5b29e5fdc4"
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-v3/azure-cli-2.77.0-macos-arm64-nopython-signed-notarized.tar.gz"
  end

  on_intel do
    sha256 "3f3627cd2aa5d0e7498e5429b833c7a31c721a15fec2a3c4a69d5b206e792e7d"
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-v3/azure-cli-2.77.0-macos-x86_64-nopython-signed-notarized.tar.gz"
  end

  name "Azure CLI"
  desc "Microsoft Azure CLI (Lightweight - uses Homebrew Python)"
  homepage "https://docs.microsoft.com/cli/azure/"

  depends_on formula: "python@3.13"

  binary "bin/az"

  zap trash: "~/.azure"
end
