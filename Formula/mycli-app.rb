# Homebrew formula for mycli-app
class MycliApp < Formula
  desc "Simple Azure-like CLI tool by Naga"
  homepage "https://github.com/naga-nandyala/mycli-app"
  version "0.1.1"
  license "MIT"

  base_url = "https://github.com/naga-nandyala/mycli-app/releases/download/v#{version}"
  
  if Hardware::CPU.arm?
    url "#{base_url}/mycli-#{version}-macos-arm64.tar.gz"
    sha256 "b70c19ce802883369ee44755aae38e690ec1275f5020244ff3cd25bbdd50a8eb"
  else
    url "#{base_url}/mycli-#{version}-macos-x86_64.tar.gz"
    sha256 "b0910462afdbf71861d63df5387e03aa473b1374eb2bb705528ce85ab966caed"
  end

  def install
    bin.install "mycli"
  end

  test do
    assert_match "MyCliApp version", shell_output("#{bin}/mycli --version")
  end
end
