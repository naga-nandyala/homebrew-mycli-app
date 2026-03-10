cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.84.0"
  sha256 arm:   "5493fa2725a7d2bee602230e11bded624df2a00c3b8db37dadbadbef275d1c7b",
         intel: "5498695a7fa89091bdab1a9b874dd3eec72f280cd1eee11abedc896d57d1b6a6"

  url "https://github.com/naga-nandyala/azure-cli-broker-new/releases/download/azure-cli-#{version}/azure-cli-#{version}-#{os}-#{arch}.tar.gz"
  name "Azure CLI"
  desc "Microsoft Azure CLI 2.0"
  homepage "https://docs.microsoft.com/cli/azure/overview"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "python@3.13"

  binary "bin/az"
  zsh_completion "completions/zsh/_az"
  bash_completion "completions/bash/az"
  fish_completion "completions/fish/az.fish"

  zap trash: "~/.azure"
end
