cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.84.0"
  sha256 arm:   "d62807035354c0d1dac211f244403b59e1dac0d48365427fa3951639d51f11eb",
         intel: "b46a9d8b858c69a36a6a005c4072ffcb232fdd2cfa765127eab54390d91aee91"

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
