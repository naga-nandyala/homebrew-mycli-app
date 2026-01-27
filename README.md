# Homebrew Tap for mycli-app

Official Homebrew tap for `mycli-app`, a simple Azure-like CLI tool.

## Installation

```bash
brew install naga-nandyala/mycli-app/mycli-app
```

## Usage

```bash
mycli --version              # Check version
mycli login --demo           # Login (demo mode)
mycli --help                 # Get help
```

## Repository Structure

```
Formula/     # Homebrew formulas for CLI installation
Casks/       # Homebrew casks for package-based installation
```

### Available Formulas
- `mycli-app.rb` - Main binary installation (recommended)
- `mycli-app-src.rb` - Source-based installation
- `mycli-app-venv.rb` - Python virtual environment installation
- `azure-cli.rb` - Azure CLI formula
- `azure-cli@2.80.rb` - Azure CLI version 2.80
- `azure-cli-pr.rb` - Azure CLI PR build
- `azure-cli-tarball.rb` - Azure CLI tarball installation
- `azure-cli-tarball-signed.rb` - Signed Azure CLI tarball
- `azure-cli-tarball-signed-notarized-v2.rb` - Signed and notarized Azure CLI tarball v2
- `azure-cli-zip-signed.rb` - Signed Azure CLI zip

### Available Casks
- `mycli-app-pkg.rb` - macOS package installer
- `mycli-app-venv.rb` - Virtual environment package
- `mycli-app-pkg-pj2.rb` - macOS package installer (pj2)
- `mycli-app-pkgnew-pj2.rb` - New macOS package installer (pj2)
- `mycli-app-pkgsign-pj2.rb` - Signed macOS package installer (pj2)
- `mycli-app-venv-pj2.rb` - Virtual environment package (pj2)
- `azure-cli-pkg.rb` - Azure CLI macOS package
- `azure-cli-pr.rb` - Azure CLI PR build cask
- `azure-cli-pr2.rb` - Azure CLI PR2 build cask
- `azure-cli-pr2-test.rb` - Azure CLI PR2 test cask
- `azure-cli-tarball-signed-notarized-v2.rb` - Signed and notarized Azure CLI tarball v2

## Links

- Homepage: https://github.com/naga-nandyala/mycli-app
- Releases: https://github.com/naga-nandyala/mycli-app/releases
