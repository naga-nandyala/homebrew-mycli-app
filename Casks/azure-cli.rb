cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.77.0"
  sha256 arm:   "29530827162ddb6831e6109b5d9e04b558b5f0bd6290e46404a2a6bc2229c668",
         intel: "52c9df8a8c4dce81eb68b4eebd2c6fe5b1cb6506f35716ebfb9be3f1b958ba7e"

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
