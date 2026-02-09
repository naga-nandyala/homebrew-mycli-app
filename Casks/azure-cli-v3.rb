cask "azure-cli-v3" do
  version "2.77.0"

  on_arm do
    sha256 "06e94ac5d9e8eade8a8caa59d3611729786cceb2746a03a13968e8f9a24dc2a9"
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-v3/azure-cli-2.77.0-macos-arm64-nopython-signed-notarized.tar.gz"
  end

  on_intel do
    sha256 "86651ab69a9ce260f9c655b6a30ed2271f9dc0a632986c3cdbb4d8071fbe6d4d"
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-v3/azure-cli-2.77.0-macos-x86_64-nopython-signed-notarized.tar.gz"
  end

  name "Azure CLI"
  desc "Microsoft Azure CLI (Lightweight - uses Homebrew Python)"
  homepage "https://docs.microsoft.com/cli/azure/"

  depends_on formula: "python@3.13"

  binary "bin/az"

  zap trash: "~/.azure"
end
