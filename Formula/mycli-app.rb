# Homebrew formula for mycli-app
class MycliApp < Formula
  desc "Simple Azure-like CLI tool by Naga"
  homepage "https://github.com/naga-nandyala/mycli-app"
  version "0.1.0"
  license "MIT"

  base_url = "https://github.com/naga-nandyala/mycli-app/releases/download/v#{version}"
  
  if Hardware::CPU.arm?
    url "#{base_url}/mycli-#{version}-macos-arm64.tar.gz"
    sha256 "b7b7b38e23dae6cc94240ddf31bc7f06aab19a250e330fa87561e14ab5932a71"
  else
    url "#{base_url}/mycli-#{version}-macos-x86_64.tar.gz"
    sha256 "fb84bc67f56e57bfa37103d27a9cb1652acfca3c4c4dd4df7ef2b29fcef88c94"
  end

  def install
    bin.install "mycli"
  end

  test do
    assert_match "MyCliApp version", shell_output("#{bin}/mycli --version")
  end
end
