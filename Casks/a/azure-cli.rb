cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.83.0"
  sha256 arm:   "bf352808d16faa9c64d5a116c73bea44753225deaf562d1c934e941e6f9cda82",
         intel: "38461891a4eda1866bd9e88407b24b3fd7e5cc3326abffcca63dd50577880951"

  url "https://github.com/naga-nandyala/azure-cli-2.83.0-content/releases/download/azure-cli-#{version}/azure-cli-#{version}-#{os}-#{arch}.tar.gz"
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
