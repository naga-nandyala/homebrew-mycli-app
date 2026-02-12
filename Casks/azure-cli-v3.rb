cask "azure-cli-v3" do
  version "2.77.0"

  on_arm do
    sha256 "1cc7f4ed4ce1fcb34e47d214d17851683d8230cb55caa5f5a7695db415db96d5"
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-v3/azure-cli-2.77.0-macos-arm64-nopython-signed-notarized.tar.gz"
  end

  on_intel do
    sha256 "8cad216c2cf1c1a9b6d095ffed8e0414ebd4516c58b03adb8f56945ed4c7c573"
    url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v2.77.0-v3/azure-cli-2.77.0-macos-x86_64-nopython-signed-notarized.tar.gz"
  end

  name "Azure CLI"
  desc "Microsoft Azure CLI (Lightweight - uses Homebrew Python)"
  homepage "https://docs.microsoft.com/cli/azure/"

  depends_on formula: "python@3.13"

  binary "bin/az"

  zap trash: "~/.azure"
end
