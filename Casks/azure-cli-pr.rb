cask "azure-cli-pr" do
  version "2.77.0"
  sha256 "14216caba61e2e23e3ad96a3e9ed9e5bfc0acfbb1d27b592b024f9a0c5e523a2"

  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0/azure-cli-2.77.0-macos-arm64-notarized.pkg"
  name "Azure CLI PR"
  desc "Microsoft Azure command-line interface (PKG installer)"
  homepage "https://learn.microsoft.com/cli/azure/"

  depends_on macos: ">= :catalina"

  pkg "azure-cli-2.77.0-macos-arm64-notarized.pkg"

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
