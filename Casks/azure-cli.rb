cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.83.0"
  sha256 arm:   "c852d72030273b76ef5e8f35cd665a4c3b578db1b2f73412faefee9cdbc18329",
         intel: "8cd6a47b698a77be4c8622916d47fa0660512fae0ce2748f8692a8b6be982fa6"

  url "https://github.com/naga-nandyala/azure-cli-latest/releases/download/azure-cli-#{version}/azure-cli-#{version}-#{os}-#{arch}.tar.gz"
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
