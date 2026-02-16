cask "azure-cli-v3" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.77.0"
  sha256 arm:   "6f79c3ffbc408f2bd9d0829cc5fdbec849d75d1ee65e1b80e6ea1de8391e1b59",
         intel: "38fe4356047d4a9198259949eadb15cbcc11d40d52a1f5b96c8301c63e474c07"

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
