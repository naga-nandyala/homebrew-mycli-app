cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.84.0"
  sha256 arm:   "055697927be642c5d7d4e3ac2b3b44086f2f0c8ad8aea8ff1003b38375b6da22",
         intel: "fe0cfd9e87ee426e1ab11e76d4c2be0e0bb337fc7ca00391f95e36c1e9db6897"

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
