cask "azure-cli-v3" do
  version ""

  on_arm do
    sha256 "79df1de0ca594b7f6c79bb67353b1787d03ff0fc314677933adfe8ce22a6ba33"
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v-v3/azure-cli--macos-arm64-nopython-signed-notarized.tar.gz"
  end

  on_intel do
    sha256 "058dc96715f9c273e696a4ed70a2a78e4e9dae7f28f4b9cdfc1ee1efb8899422"
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v-v3/azure-cli--macos-x86_64-nopython-signed-notarized.tar.gz"
  end

  name "Azure CLI"
  desc "Microsoft Azure CLI (Lightweight - uses Homebrew Python)"
  homepage "https://docs.microsoft.com/cli/azure/"

  depends_on formula: "python@3.13"

  binary "bin/az"

  zap trash: "~/.azure"
end
