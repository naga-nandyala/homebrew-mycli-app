cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.77.0"
  sha256 arm:   "3a3b07e9f7b66ad090688294373034a2fc888424a4eb85670aa09556c3f5cb31",
         intel: "ca18be153311b567ee33bd7c5a85baf91bb663f163fbfbdedbb3d3ba5b2e9273"

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
