cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"

  version "2.88.0"
  sha256 arm:   "30f27075dc8bf965a15e05381fbbae42ca4060326100c6d097581cd0e330b251",
         intel: "8945009a23dcd7b3a26c2dda26948c0fd70478343b4d8fe19e2e75e4135e8c82"

  url "https://github.com/naga-nandyala/azure-cli-broker-2/releases/download/azure-cli-#{version}/azure-cli-#{version}-macos-#{arch}.tar.gz",
      verified: "github.com/naga-nandyala/azure-cli-broker-2/"
  name "Azure CLI"
  desc "Microsoft Azure CLI 2.0"
  homepage "https://docs.microsoft.com/cli/azure/overview"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "python@3.14"

  binary "bin/az"
  bash_completion "completions/bash/az"
  fish_completion "completions/fish/az.fish"
  zsh_completion "completions/zsh/_az"

  zap trash: "~/.azure"
end
