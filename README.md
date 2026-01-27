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

### Available Casks
- `mycli-app-pkg.rb` - macOS package installer
- `mycli-app-venv.rb` - Virtual environment package

## Links

- Homepage: https://github.com/naga-nandyala/mycli-app
- Releases: https://github.com/naga-nandyala/mycli-app/releases
