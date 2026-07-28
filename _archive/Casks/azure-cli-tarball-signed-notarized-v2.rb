cask "azure-cli-tarball-signed-notarized-v2" do
  version "2.77.0"
  sha256 "6e41d9fa2dbe5d66d106719a9b244a18c9bbdd723ab52f65263da9601be3f3dd"

  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-tarball-v2/azure-cli-2.77.0-macos-arm64-signed-notarized.tar.gz"
  name "Azure CLI (Tarball - Signed & Notarized v2)"
  desc "Microsoft Azure CLI installed via tar.gz - signed and notarized (passwordless)"
  homepage "https://learn.microsoft.com/cli/azure/"

  binary "bin/az"

  zap trash: "~/.azure"
end
