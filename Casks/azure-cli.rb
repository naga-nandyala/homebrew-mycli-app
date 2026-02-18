cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.77.0"
  sha256 arm:   "cb69a858a3e733fa724cb2a880410cf5787f00cdd270e3660239eaacb14a9dbd",
         intel: "97fd25b522a87ba7d03910a9abbc301fbf9017ce620d4b39d48c0e8862548090"

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
