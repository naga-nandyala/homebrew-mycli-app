cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "2.89.0"
  sha256 arm:   "f8796ec9e61a989aad58c29de0f0f844c0f71f44abcf2284c1f1ae156b8d0e1b",
    intel: "998e04b09a0cf0a7381cfc02e56b1d4dd33ba26f2fdba7364c3735d85539c496",
    arm64_linux: "35a71b2212f3d4c504e30ce4b4437d5e573751319bd9fded88127e69b0c8ab80",
    x86_64_linux: "0bd8b0e3cf3f46b88bb944dfa3497b898611162666793ab2a4dac38fb2e41f29"

  url "https://github.com/naga-nandyala/azure-cli/releases/download/azure-cli-#{version}/azure-cli-#{version}-#{os}-#{arch}.tar.gz",
      verified: "github.com/naga-nandyala/azure-cli/"
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
