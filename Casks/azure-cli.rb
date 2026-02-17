cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.77.0"
  sha256 arm:   "8c3c179b780933690507bb22ed004f6cb5236415edc146db9bb2b558920c6b8d",
         intel: "aebb0b622a5e3be3eb5ac592cde5458168e7f62e90dccf2d9000c1b929e6ff53"

  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/azure-cli-#{version}/azure-cli-#{version}-#{os}-#{arch}-nopython-signed-notarized.tar.gz"
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
