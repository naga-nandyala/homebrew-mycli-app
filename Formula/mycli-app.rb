# Homebrew formula for mycli-app
class MycliApp < Formula
  desc "Simple Azure-like CLI tool by Naga"
  homepage "https://github.com/naga-nandyala/mycli-app"
  version "0.1.0"
  license "MIT"

  base_url = "https://github.com/naga-nandyala/mycli-app/releases/download/v#{version}"
  
  if Hardware::CPU.arm?
    url "#{base_url}/mycli-#{version}-macos-arm64.tar.gz"
    sha256 "b73d2935e4bb1e35af4728f414b6f403f7715648406a64d857f80f718b939427"
  else
    url "#{base_url}/mycli-#{version}-macos-x86_64.tar.gz"
    sha256 "b46cc0d122e2321d9d86bb602374e5c1613f0aadbb8a937442248b2e12f0418d"
  end

  def install
    bin.install "mycli"
  end

  test do
    assert_match "MyCliApp version", shell_output("#{bin}/mycli --version")
  end
end
