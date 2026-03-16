cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.83.0"
  sha256 arm:   "3f744041dabf6ed579751a69b6c06d4fd0c114d937ffdc2edaa5e61be994f5e9",
         intel: "a1dc7fc3591dd54bd569a6d18dc8dc888c694aa981fe441d833f3b9b18ad3f2c"

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
