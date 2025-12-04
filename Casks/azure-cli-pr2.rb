cask "azure-cli-pr2" do
  version "3.0.0"
  sha256 "814c3ed5af2a4e2ba110a21c849240bfe5862b285a95194e42b78b2097590d71"
  
  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v3.0.0-pr2/azure-cli-3.0.0-macos-arm64-notarized.pkg"
  name "Azure CLI (PR2 - Versioned)"
  desc "Microsoft Azure Command-Line Interface with versioned installation support"
  homepage "https://docs.microsoft.com/cli/azure/"

  pkg "azure-cli-3.0.0-macos-arm64-notarized.pkg"

  postflight do
    # Display installation summary
    version_dir = "/usr/local/microsoft/azure-cli/#{version}"
    current_link = "/usr/local/microsoft/azure-cli/current"
    
    if File.directory?(version_dir)
      ohai "Azure CLI #{version} installed successfully"
      puts "Installation directory: #{version_dir}"
      
      if File.symlink?(current_link)
        active_version = File.readlink(current_link)
        puts "Active version: #{active_version}"
        
        # Check if this is an upgrade
        if active_version != version.to_s
          opoo "Previous version (#{active_version}) is still installed"
          puts "To remove old versions, run:"
          puts "  sudo /usr/local/microsoft/azure-cli/cleanup-old-versions.sh"
        end
      end
    else
      opoo "Installation directory not found: #{version_dir}"
    end
  end

  uninstall_preflight do
    current_link = "/usr/local/microsoft/azure-cli/current"
    
    if File.symlink?(current_link)
      current_version = File.readlink(current_link)
      ohai "Removing Azure CLI active version: #{current_version}"
      
      # Count total versions
      versions_dir = "/usr/local/microsoft/azure-cli"
      if Dir.exist?(versions_dir)
        version_dirs = Dir.glob("#{versions_dir}/[0-9]*").select { |f| File.directory?(f) }
        
        if version_dirs.length > 1
          opoo "You have #{version_dirs.length} versions installed"
          puts "Only the launcher and 'current' symlink will be removed."
          puts "Version directories will remain for manual inspection."
          puts ""
          puts "To remove ALL versions and data, run:"
          puts "  brew uninstall --zap --cask azure-cli-pr2"
        end
      end
    else
      opoo "No active Azure CLI installation found"
    end
  end

  uninstall pkgutil: "com.microsoft.azure.cli",
            delete:  [
              "/usr/local/bin/az",
              "/usr/local/microsoft/azure-cli/current",
              "/usr/local/microsoft/azure-cli/cleanup-old-versions.sh",
            ]

  # Note: Version directories are NOT deleted to preserve user's ability to rollback
  # Users can manually remove them or use 'zap' for complete cleanup
  
  zap trash: "~/.azure",
      rmdir: "/usr/local/microsoft/azure-cli"

  caveats <<~EOS
    Azure CLI #{version} has been installed with versioned directory structure.

    Installation location:
      /usr/local/microsoft/azure-cli/#{version}/

    Active version symlink:
      /usr/local/microsoft/azure-cli/current -> #{version}

    Launcher script:
      /usr/local/bin/az

    Multiple versions can coexist side-by-side. When you upgrade, the previous
    version will be preserved automatically.

    To remove old versions:
      sudo /usr/local/microsoft/azure-cli/cleanup-old-versions.sh

    To manually switch versions (advanced):
      sudo ln -sf <version> /usr/local/microsoft/azure-cli/current
      Example: sudo ln -sf 2.80.0 /usr/local/microsoft/azure-cli/current

    To verify installation:
      az --version
      ls -la /usr/local/microsoft/azure-cli/

    For complete removal including all versions:
      brew uninstall --zap --cask azure-cli-pr2
  EOS
end
