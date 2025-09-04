# Homebrew formula for mycli-app (venv bundling approach)
class MycliAppVenv < Formula
  desc "Simple Azure-like CLI tool by Naga (Portable Virtual Environment Bundle)"
  homepage "https://github.com/naga-nandyala/mycli-app"
  version "1.0.0"
  license "MIT"

  base_url = "https://github.com/naga-nandyala/mycli-app/releases/download/v#{version}"
  
  if Hardware::CPU.arm?
    url "#{base_url}/mycli-arm64-1.0.0-arm64.tar.gz"
    sha256 "3f6c7a989a4fed78925c1783c456ece36ad3dd73c9263a8e94211e67dc7cf4ec"
  else
    url "#{base_url}/mycli-arm64-1.0.0-x86_64.tar.gz"
    sha256 "ec4ec26d0fde77050b4265bbadf23bfa1857547dd42159fa30517c14b8872600"
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
