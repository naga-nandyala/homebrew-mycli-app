cask "azure-cli-pr" do
  version "2.0.0"
  sha256 "04f1bb4da82b675caafd1b9b434a7f663cc4f4a5f8efcd823508c06611d905f0"

  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.0.0/azure-cli-2.0.0-macos-arm64-notarized.pkg"
  name "Azure CLI PR"
  desc "Microsoft Azure command-line interface (PKG installer)"
  homepage "https://learn.microsoft.com/cli/azure/"

  depends_on macos: ">= :catalina"

  pkg "azure-cli-2.0.0-macos-arm64-notarized.pkg"

  uninstall pkgutil: "com.microsoft.azure-cli",
            delete:  [
              "/usr/local/bin/az",
              "/usr/local/microsoft/azure-cli",
            ]

  zap trash: [
    "~/.azure",
  ]

  caveats <<~EOS
    Azure CLI has been installed successfully!
    
    Installation Details:
      • Executable: /usr/local/bin/az
      • Runtime: /usr/local/microsoft/azure-cli/
    
    This is a PKG-based installation with all dependencies bundled.
    No additional Homebrew formula dependencies required!
    
    To verify installation:
      az --version
    
    To get started:
      az login
      az account list
    
    Documentation:
      https://learn.microsoft.com/cli/azure/
  EOS
end
