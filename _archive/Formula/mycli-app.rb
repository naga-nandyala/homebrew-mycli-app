# Homebrew formula for mycli-app
class MycliApp < Formula
  desc "Simple Azure-like CLI tool by Naga"
  homepage "https://github.com/naga-nandyala/mycli-app"
  version "0.1.2"
  license "MIT"

  base_url = "https://github.com/naga-nandyala/mycli-app/releases/download/v#{version}"
  
  if Hardware::CPU.arm?
    url "#{base_url}/mycli-#{version}-macos-arm64.tar.gz"
    sha256 "1c08b0414ae47c2ddda605ad3b9b7ea269ae4370ee0639f655c188c0c0e9e349"
  else
    url "#{base_url}/mycli-#{version}-macos-x86_64.tar.gz"
    sha256 "97547037a212be3715c0e1e8a0050bab352589195b769b0811300836ea699515"
  end

  def install
    bin.install "mycli"
  end

  test do
    assert_match "MyCliApp version", shell_output("#{bin}/mycli --version")
  end
end
