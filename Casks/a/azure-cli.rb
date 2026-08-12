cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "2.89.0"
  sha256 arm:          "3565cc351f3d5d33dbcad7592b143efe085221fe9d686faada7e695f3e2d4a2a",
         intel:        "d33abe740bd29f954dc99d6905a8ea9cbafde7d78f68d595f0d53dd696215a62",
         arm64_linux:  "842ffe48846a00cf98531d2f184fe171aeb2958d0d543cd306c6d485a682272d",
         x86_64_linux: "35176dc3d079500e4f8a718d44f3fb698f244afb0395ddea055f0939a355561f"

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
