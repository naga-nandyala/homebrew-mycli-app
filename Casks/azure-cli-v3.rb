cask "azure-cli-v3" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.77.0"
  sha256 arm:   "f1ee54b388e2e395e543b19825e7f811dd6fa262d6d7536a850cd099b50aad95",
         intel: "1e131bd0f0e8b4f07f008ddf1f0051a15342bb59de4eecae34cf22a4dfa2dea5"

  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v#{version}-v3/azure-cli-#{version}-#{os}-#{arch}-nopython-signed-notarized.tar.gz"
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
