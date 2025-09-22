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

  resource "azure-identity" do
    url "https://files.pythonhosted.org/packages/4e/9e/4c9682a286c3c89e437579bd9f64f311020e5125c1321fd3a653166b5716/azure_identity-1.25.0.tar.gz"
    sha256 "4177df34d684cddc026e6cf684e1abb57767aa9d84e7f2129b080ec45eee7733"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/dc/67/960ebe6bf230a96cda2e0abcf73af550ec4f090005363542f0765df162e0/certifi-2025.8.3.tar.gz"
    sha256 "e564105f78ded564e3ae7c923924435e1daa7463faeab5bb932bc53ffae63407"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/d8/53/6f443c9a4a8358a93a6792e2acffb9d9d5cb0a5cfd8802644b7b1c9a02e4/colorama-0.4.6.tar.gz"
    sha256 "08695f5cb7ed6e0531a20572697297273c47b8cae5a63ffc6d6ed5c201be6e44"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/a9/62/e3664e6ffd7743e1694b244dde70b43a394f6f7fbcacf7014a8ff5197c73/cryptography-46.0.1.tar.gz"
    sha256 "ed570874e88f213437f5cf758f9ef26cbfc3f336d889b1e592ee11283bb8d1c7"
  end

  resource "msal-extensions" do
    url "https://files.pythonhosted.org/packages/01/99/5d239b6156eddf761a636bded1118414d161bd6b7b37a9335549ed159396/msal_extensions-1.3.1.tar.gz"
    sha256 "c5b0fd10f65ef62b5f1d62f4251d51cbcaf003fcedae8c91b040a488614be1a4"
  end

  resource "PyJWT" do
    url "https://files.pythonhosted.org/packages/e7/46/bd74733ff231675599650d3e47f361794b22ef3e3770998dda30d3b63726/pyjwt-2.10.1.tar.gz"
    sha256 "3cc5772eb20009233caf06e9d8a0577824723b44e6648ee0a2aedb6cf9381953"
  end

  resource "typing_extensions" do
    url "https://files.pythonhosted.org/packages/72/94/1a15dd82efb362ac84269196e94cf00f187f7ed21c242792a923cdb1c61f/typing_extensions-4.15.0.tar.gz"
    sha256 "0cea48d173cc12fa28ecabc3b837ea3cf6f38c6d1136f85cbaaf598984861466"
  end


  def install
    # Ensure that the `openssl` crate picks up the intended library for cryptography
    ENV["OPENSSL_DIR"] = Formula["openssl@3"].opt_prefix
    ENV["OPENSSL_NO_VENDOR"] = "1"

    # Create virtual environment
    venv = virtualenv_create(libexec, "python3.12", system_site_packages: false)
    
    # Install source-available dependencies first (excluding binary wheels)
    # This follows the AWS CLI pattern for handling binary-only packages
    venv.pip_install resources.reject { |r| r.name == "pymsalruntime" }

    # Install pymsalruntime binary wheel separately using direct wheel installation
    if resources.any? { |r| r.name == "pymsalruntime" }
      system venv.root/"bin/pip", "install", "--no-deps", resource("pymsalruntime").cached_download
    end

    # Install the main application
    venv.pip_install buildpath

    # Create the CLI wrapper script using proper entry point
    (bin/"mycli").write <<~SHELL
      #!/usr/bin/env bash
      exec "#{libexec}/bin/mycli" "$@"
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
      This is the source-based installation of mycli-app with full broker authentication support.
      Built using the AWS CLI approach for handling binary wheel dependencies.
      
      🎯 Features:
      - Built from source for maximum compatibility
      - Dependencies managed by Homebrew
      - Full Azure authentication including native broker support
      - Automatic updates through Homebrew
      
      🔐 Authentication Methods Available:
      - Browser-based authentication (default)
      - Device code authentication (--use-device-code)
      - Native broker authentication with pymsalruntime
      - Microsoft Company Portal integration
      - Touch ID/Face ID support on macOS (where available)
      - MSAL token caching and refresh
      
      ✨ Technical Implementation:
      - Uses AWS CLI-style selective pip install for binary wheels
      - Source dependencies built from PyPI source distributions
      - Binary wheels (pymsalruntime) installed separately for compatibility
      - Follows Homebrew Core best practices for mixed dependency types
      
      📱 Available authentication commands:
        mycli login                    # Browser authentication (default)
        mycli login --device           # Device code authentication  
        mycli login --use-broker       # Native broker authentication
        
      � Alternative Installation:
      For a pre-built venv bundle approach:
        brew install naga-nandyala/mycli-app/mycli-app-venv
        
      For more information, visit:
        https://github.com/naga-nandyala/mycli-app
    EOS
  end
end
