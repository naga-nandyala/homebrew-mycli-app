cask "azure-cli-v3" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.77.0"
  sha256 arm:   "29845a184a1bb5f21f48ad48fcf90d059ed065cc92ef1162c1aa21c9ea616c05",
         intel: "f53d0b5872b8fe3038d2d82692ec1f82fa8070d8b3f8643a04cb7ce5256557e8"

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
