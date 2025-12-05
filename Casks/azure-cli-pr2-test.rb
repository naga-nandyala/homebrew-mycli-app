cask "azure-cli-pr2-test" do
  version "3.0.0"
  sha256 "6b6cf490e578930d468f9b54c4e71b078abea3bf130c23462237d1dea8f1424a"

  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v3.0.0-test-unsigned/azure-cli-3.0.0-macos-arm64-unsigned.pkg"
  name "Azure CLI (Test - Unsigned)"
  desc "UNSIGNED TEST - Azure CLI with versioned installation"
  homepage "https://github.com/naga-nandyala/azure-cli-pkg-1"

  pkg "azure-cli-3.0.0-macos-arm64-unsigned.pkg"

  caveats <<~EOS
    Azure CLI 3.0.0 (UNSIGNED TEST BUILD)
    Installation: /usr/local/microsoft/azure-cli/3.0.0/
    Symlink: /usr/local/microsoft/azure-cli/current -> 3.0.0
    Launcher: /usr/local/bin/az
  EOS

  zap trash: [
    "/usr/local/bin/az",
    "/usr/local/microsoft/azure-cli",
  ]
end
