cask "mycli-app-venv" do
  version "1.0.1"

  on_arm do
    sha256 "fd4d561e0d01e8bfd644d904e4714408c211a673408e34045e07bfac413a086c"
    url "https://github.com/naga-nandyala/mycli-app/releases/download/v#{version}/mycli-arm64-#{version}-arm64.tar.gz"
  end

  on_intel do
    sha256 "8ba3bf2a5f136f469cc33669ce4de57db76a1f37464f7f691a778e848a537001"
    url "https://github.com/naga-nandyala/mycli-app/releases/download/v#{version}/mycli-x86_64-#{version}-x86_64.tar.gz"
  end

  name "MyCLI App (Venv Bundling)"
  desc "Simple Azure-like CLI tool with portable Python virtual environment"
  homepage "https://github.com/naga-nandyala/mycli-app"

  binary "bin/mycli"

  caveats <<~EOS
    This is the venv bundling version of mycli-app, which includes a complete
    portable Python virtual environment with all dependencies.

    Features:
    - Complete Python virtual environment
    - Azure authentication with MSAL broker support
    - Native architecture support (Intel and Apple Silicon)
    - All dependencies bundled for offline operation

    To use Azure authentication features, run:
      mycli --help
  EOS
end
