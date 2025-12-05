cask "azure-cli-pr2" do
  version "3.0.0"
  sha256 "dfa66b34d53ec0e5702448efbc06c5c6bbdf7246f62f22dba0fa9c8c09355c31"

  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v3.0.0-pr2/azure-cli-3.0.0-macos-arm64-notarized.pkg"
  name "Azure CLI"
  desc "Azure CLI with versioned installation (notarized)
  homepage "https://github.com/naga-nandyala/azure-cli-pkg-1"

  pkg "azure-cli-3.0.0-macos-arm64-notarized.pkg"

  caveats <<~EOS
    Azure CLI 3.0.0
    Installation: /usr/local/microsoft/azure-cli/3.0.0/
    Symlink: /usr/local/microsoft/azure-cli/current -> 3.0.0
    Launcher: /usr/local/bin/az
  EOS

  zap trash: [
    "/usr/local/bin/az",
    "/usr/local/microsoft/azure-cli",
  ]
end
