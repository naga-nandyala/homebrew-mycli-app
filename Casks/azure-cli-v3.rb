cask "azure-cli-v3" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.77.0"
  sha256 arm:   "1df515d44db547dfc6412cc02dd2146ff3ef6cf0fafa9fc2f87f552faedf1b27",
         intel: "360539ff2c0f44f370de41dd5cf7e4bd835f6dbac8aa1fca11bb11bce039e63b"

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
