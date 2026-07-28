# Homebrew formula for mycli-app (venv bundling approach)
class MycliAppVenv < Formula
  desc "Simple Azure-like CLI tool by Naga (Portable Virtual Environment Bundle)"
  homepage "https://github.com/naga-nandyala/mycli-app"
  version "0.0.1"
  license "MIT"

  base_url = "https://github.com/naga-nandyala/mycli-app/releases/download/v#{version}"
  
  if Hardware::CPU.arm?
    url "#{base_url}/mycli-arm64-0.0.1-arm64.tar.gz"
    sha256 "683d84e6924ffc44c4448da4aa6cab57c9ece12e225153af4ad55ea7b81dfd20"
  else
    url "#{base_url}/mycli-x86_64-0.0.1-x86_64.tar.gz"
    sha256 "65c89a59666b27c40236fa113284870a65361f59ba4596153a48769b7dde3b43"
  end

  def install
    # The venv bundle contains a complete virtual environment
    # Install the entire bundle to libexec and symlink the binary
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/mycli"
  end

  test do
    assert_match "MyCliApp version", shell_output("#{bin}/mycli --version")
    
    # Test Azure authentication capabilities
    help_output = shell_output("#{bin}/mycli --help")
    assert_match "azure", help_output.downcase
  end
  
  def caveats
    <<~EOS
      This is the venv bundling version of mycli-app, which includes a complete
      portable virtual environment with all dependencies.
      
      Features:
      - Complete Python virtual environment
      - Azure authentication with MSAL broker support
      - Native architecture support (Intel and Apple Silicon)
      - All dependencies bundled for offline operation
      
      To use Azure authentication features, run:
        mycli --help
        
      For the alternative PyInstaller version, install:
        brew install naga-nandyala/mycli-app/mycli-app
        
      For more information, visit:
        https://github.com/naga-nandyala/mycli-app
    EOS
  end
end
