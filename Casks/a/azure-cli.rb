cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"

  version "2.88.0"
  sha256 arm:   "c8b1e881221d17c5465da809bf39e0d165f68002d8367d17bc0dc19aa22077a6",
         intel: "497db1c775aa96f8ca69d7b4187f9916fdb75f42378dd866fec2e4b27922a21b"

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
