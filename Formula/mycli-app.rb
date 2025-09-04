# Homebrew formula for mycli-app (PyInstaller approach)
class MycliApp < Formula
  desc "Simple Azure-like CLI tool by Naga (Single-file PyInstaller executable)"
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
    # PyInstaller creates a single executable binary
    bin.install "mycli"
  end

  test do
    assert_match "MyCliApp version", shell_output("#{bin}/mycli --version")
    
    # Test Azure authentication capabilities
    help_output = shell_output("#{bin}/mycli --help")
    assert_match "azure", help_output.downcase
  end
  
  def caveats
    <<~EOS
      This is the PyInstaller version of mycli-app, which provides a single
      executable file with all dependencies bundled.
      
      Features:
      - Single-file executable (no external dependencies)
      - Fast startup and execution
      - Azure authentication with MSAL broker support
      - Native architecture support (Intel and Apple Silicon)
      
      To use Azure authentication features, run:
        mycli --help
        
      For the alternative venv bundling version, install:
        brew install naga-nandyala/mycli-app/mycli-app-venv
        
      For more information, visit:
        https://github.com/naga-nandyala/mycli-app
    EOS
  end
end
