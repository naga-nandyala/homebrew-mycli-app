cask "azure-cli" do
  arch arm: "arm64", intel: "x86_64"
  os macos: "macos"

  version "2.84.0"
  sha256 arm:   "04c29951f02b4502734e9d08b0e7a6c6facee4ee278c42cf2da6e999bcd5c812",
         intel: "051e04641df5329e847a0f45001c940d6d9f2a6da5ae7977c43c7eb92f2a9920"

  url "https://github.com/naga-nandyala/azure-cli-broker-new/releases/download/azure-cli-#{version}/azure-cli-#{version}-#{os}-#{arch}.tar.gz"
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
# cask "azure-cli" do
#   arch arm: "arm64", intel: "x86_64"
#   os macos: "macos"

#   version "2.83.0"
#   sha256 arm:   "c852d72030273b76ef5e8f35cd665a4c3b578db1b2f73412faefee9cdbc18329",
#          intel: "8cd6a47b698a77be4c8622916d47fa0660512fae0ce2748f8692a8b6be982fa6"

#   url "https://github.com/naga-nandyala/azure-cli-latest/releases/download/azure-cli-#{version}/azure-cli-#{version}-#{os}-#{arch}.tar.gz"
#   name "Azure CLI"
#   desc "Microsoft Azure CLI 2.0"
#   homepage "https://docs.microsoft.com/cli/azure/overview"

#   livecheck do
#     url :url
#     strategy :github_latest
#   end

#   depends_on formula: "python@3.13"

#   binary "bin/az"

#   zap trash: "~/.azure"
# end
