# cask "azure-cli" do
#   arch arm: "arm64", intel: "x86_64"
#   os macos: "macos"

#   version "2.83.0"
#   sha256 arm:   "b3ce3f73b379997901b821527afaf30fcf1c5d8758606dcdc35a3c09c9722230",
#          intel: "b5d0b4b6758439e57c7f353df4fb1f857d444e8572aaa6adfc50297452870324"

#   url "https://github.com/naga-nandyala/azure-cli-2.83.0-content/releases/download/azure-cli-#{version}/azure-cli-#{version}-#{os}-#{arch}.tar.gz"
#   name "Azure CLI"
#   desc "Microsoft Azure CLI 2.0"
#   homepage "https://docs.microsoft.com/cli/azure/overview"

#   livecheck do
#     url :url
#     strategy :github_latest
#   end

#   depends_on formula: "python@3.13"

#   binary "bin/az"
#   zsh_completion "completions/zsh/_az"
#   bash_completion "completions/bash/az"
#   fish_completion "completions/fish/az.fish"

#   zap trash: "~/.azure"
# end
cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.84.0"
  sha256 arm:   "0aa6ad99e7cac0d2a6120d790fc71d7e0fe7735f33669deb1cda154dc404bc6f",
         intel: "d24cb852c55ed7255c669bf68bb54cc40d2c904b0a509e6f1d377353d4e9be0f"

  url "https://github.com/naga-nandyala/azure-cli-broker-new/releases/download/azure-cli-#{version}/azure-cli-#{version}-#{os}-#{arch}.tar.gz"
  name "Azure CLI"
  desc "Microsoft Azure CLI 2.0"
  homepage "https://docs.microsoft.com/cli/azure/overview"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "python@3.13"

#   binary "bin/az"
#   zsh_completion "completions/zsh/_az"
#   bash_completion "completions/bash/az"
#   fish_completion "completions/fish/az.fish"

#   zap trash: "~/.azure"
# end
