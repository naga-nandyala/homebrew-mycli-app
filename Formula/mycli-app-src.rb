# Homebrew formula for mycli-app (source-based installation)
class MycliAppSrc < Formula
  include Language::Python::Virtualenv

  desc "Simple Azure-like CLI tool by Naga (Source Installation)"
  homepage "https://github.com/naga-nandyala/mycli-app"
  url "https://github.com/naga-nandyala/mycli-app/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "d11b7315068bce4f76989d79f05383cd06d0dff64e288a94371e3a0d631752a1"
  license "MIT"
  head "https://github.com/naga-nandyala/mycli-app.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  bottle do
    # Homebrew will generate these automatically when building bottles
  end

  depends_on "python@3.12"

  # Build dependencies for cryptography
  depends_on "rust" => :build
  depends_on "pkgconf" => :build
  depends_on "openssl@3"

  uses_from_macos "libffi"

  resource "click" do
    url "https://files.pythonhosted.org/packages/d5/99/286fd2fdfb501620a9341319ba47444040c7b3094d3b6c797d7281469bf8/click-8.0.0.tar.gz"
    sha256 "7d8c289ee437bcb0316820ccee14aefcb056e58d31830ecab8e47eda6540e136"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/55/d5/c35bd3e63757ac767105f8695b055581d8b8dd8c22fef020ebefa2a3725d/colorama-0.4.0.zip"
    sha256 "c9b54bebe91a6a803e0772c8561d53f2926bfeb17cd141fbabcb08424086595c"
  end

  resource "azure-identity" do
    url "https://files.pythonhosted.org/packages/fa/d7/a7402d68d1975d869ce3ba7b6e11983310c12ff8793f0ebf01cd7ca1f398/azure-identity-1.12.0.zip"
    sha256 "7f9b1ae7d97ea7af3f38dd09305e19ab81a1e16ab66ea186b6579d85c1ca2347"
  end

  resource "azure-mgmt-core" do
    url "https://files.pythonhosted.org/packages/b8/d1/924eed2ee15100f288b2c349e32bceacda1f7783ad07d4e5893b029660b0/azure-mgmt-core-1.3.0.zip"
    sha256 "3ffb7352b39e5495dccc2d2b47254f4d82747aff4735e8bf3267c335b0c9bb40"
  end

  resource "azure-core" do
    url "https://files.pythonhosted.org/packages/f2/b0/334c52e5bee1c46aec7a1b62739be6ea9c19ace38f54ca4510d45398071d/azure-core-1.24.0.zip"
    sha256 "345b1b041faad7d0205b20d5697f1d0df344302e7aaa8501905580ff87bd0be5"
  end

  resource "msal" do
    url "https://files.pythonhosted.org/packages/c5/f8/05c343f2652b5b32f063bc908f428ffd14da65939d96b7adc48986f242a8/msal-1.20.0.tar.gz"
    sha256 "78344cd4c91d6134a593b5e3e45541e666e37b747ff8a6316c3668dd1e6ab6b2"
  end


  def install
    # Ensure that the `openssl` crate picks up the intended library for cryptography
    ENV["OPENSSL_DIR"] = Formula["openssl@3"].opt_prefix
    ENV["OPENSSL_NO_VENDOR"] = "1"

    # Create virtual environment
    venv = virtualenv_create(libexec, "python3.12", system_site_packages: false)
    
    # Install all Python dependencies
    venv.pip_install resources

    # Install the main application
    venv.pip_install buildpath

    # Create the CLI wrapper script
    (bin/"mycli").write <<~SHELL
      #!/usr/bin/env bash
      PYTHONPATH="#{libexec}/lib/python3.12/site-packages" #{libexec}/bin/python -m mycli_app.cli "$@"
    SHELL

    # Generate shell completions if supported
    # generate_completions_from_executable(bin/"mycli", "--completion", base_name: "mycli")
  end

  test do
    # Test basic functionality
    assert_match version.to_s, shell_output("#{bin}/mycli --version")
    
    # Test help command
    help_output = shell_output("#{bin}/mycli --help")
    assert_match "Usage:", help_output
    
    # Test Azure-related functionality is available
    assert_match "azure", help_output.downcase
  end

  def caveats
    <<~EOS
      This is the source-based installation of mycli-app, which builds from source
      and manages dependencies through Homebrew's Python virtual environment system.
      
      Features:
      - Built from source for maximum compatibility
      - Dependencies managed by Homebrew
      - Azure authentication with MSAL support
      - Automatic updates through Homebrew
      
      Benefits of this approach:
      - Smaller download size
      - Better integration with system Python
      - Easier dependency management
      - Automatic security updates for dependencies
      
      To use Azure authentication features, run:
        mycli --help
        
      For the alternative venv bundle version, install:
        brew install naga-nandyala/mycli-app/mycli-app-venv
        
      For more information, visit:
        https://github.com/naga-nandyala/mycli-app
    EOS
  end
end
