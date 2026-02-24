cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.77.0"
  sha256 arm:   "b67c95d3fa1ec30917d9eedd853b6fc535a26302bec0b727dc39358f56902da5",
         intel: "9826145058553f790dfe3f133eff0a63ba5aa17291545dbe50b357a7241f8cea"

  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/azure-cli-#{version}/azure-cli-#{version}-#{os}-#{arch}.tar.gz"
  name "Azure CLI"
  desc "Microsoft Azure CLI 2.0"
  homepage "https://docs.microsoft.com/cli/azure/overview"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "python@3.13"

  binary "bin/az"

  zap trash: "~/.azure"
end
