cask "azure-cli-pr2" do
  version "3.0.0"
  sha256 "326e2939e774ee7178d98d9da226b9c8917a104d41364a43b7fd5b1bffa2a60a"

  url "https://github.com/naga-nandyala/azure-cli-pkg-1/releases/download/v3.0.0-pr2/azure-cli-3.0.0-macos-arm64-notarized.pkg"
  name "Azure CLI (PR2 - Versioned)"
  desc "Microsoft Azure CLI with versioned installation support"
  homepage "https://docs.microsoft.com/cli/azure/"

  pkg "azure-cli-#{version}-macos-arm64-notarized.pkg"

  postflight do
    version_dir = "/usr/local/microsoft/azure-cli/#{version}"
    current_link = "/usr/local/microsoft/azure-cli/current"
    launcher = "/usr/local/bin/az"
    python_bin = "#{current_link}/bin/python3"

    # Ensure installation directory exists
    unless File.directory?(version_dir)
      opoo "Installation directory not found: #{version_dir}"
      next
    end

    # Remove existing 'current' symlink or file
    if File.symlink?(current_link) || File.exist?(current_link)
      system_command "/bin/rm", args: ["-f", current_link], sudo: true
    end

    # Create symlink pointing to this version
    system_command "/bin/ln", args: ["-sf", version_dir, current_link], sudo: true
    ohai "Created symlink: #{current_link} -> #{version_dir}"

    # Patch az launcher shebang to correct python
    system_command "/usr/bin/env", args: ["sed", "-i", "''", "1s|.*|#!#{python_bin}|", "#{current_link}/bin/az"], sudo: true
    ohai "Patched launcher shebang to: #{python_bin}"

    # Remove existing /usr/local/bin/az
    if File.exist?(launcher) || File.symlink?(launcher)
      system_command "/bin/rm", args: ["-f", launcher], sudo: true
    end

    # Create a wrapper script that sets PYTHONWARNINGS=ignore
    wrapper_script = <<~EOS
      #!/bin/bash
      export PYTHONWARNINGS="ignore"
      exec "#{current_link}/bin/az" "$@"
    EOS
    File.write("/tmp/az_wrapper.sh", wrapper_script)
    system_command "/bin/mv", args: ["/tmp/az_wrapper.sh", launcher], sudo: true
    system_command "/bin/chmod", args: ["+x", launcher], sudo: true
    ohai "Created launcher wrapper: #{launcher} (PYTHONWARNINGS=ignore)"

    # Notify about other installed versions
    versions_dir = "/usr/local/microsoft/azure-cli"
    version_dirs = Dir.glob("#{versions_dir}/[0-9]*").select { |f| File.directory?(f) }
    if version_dirs.length > 1
      opoo "Multiple Azure CLI versions detected (#{version_dirs.length})."
      puts "Previous versions are preserved automatically."
      puts "To clean up older versions, run:"
      puts "  sudo /usr/local/microsoft/azure-cli/cleanup-old-versions.sh"
    end

    ohai "Azure CLI #{version} installed successfully!"
    puts "Installation directory: #{version_dir}"
    puts "Active version symlink: #{current_link} -> #{version_dir}"
    puts "Launcher script: #{launcher} -> #{current_link}/bin/az (wrapper sets PYTHONWARNINGS=ignore)"
  end

  uninstall_preflight do
    current_link = "/usr/local/microsoft/azure-cli/current"
    if File.symlink?(current_link)
      active_version = File.readlink(current_link)
      ohai "Removing active Azure CLI version: #{active_version}"
    else
      opoo "No active Azure CLI symlink found"
    end
  end

  uninstall pkgutil: "com.microsoft.azure.cli",
            delete: [
              "/usr/local/bin/az",
              "/usr/local/microsoft/azure-cli/current",
              "/usr/local/microsoft/azure-cli/cleanup-old-versions.sh",
            ]

  zap trash: "~/.azure",
      rmdir: "/usr/local/microsoft/azure-cli"

  caveats <<~EOS
    Azure CLI #{version} has been installed with versioned directory structure.

    Installation location:
      /usr/local/microsoft/azure-cli/#{version}/

    Active version symlink:
      /usr/local/microsoft/azure-cli/current -> /usr/local/microsoft/azure-cli/#{version}

    Launcher script:
      /usr/local/bin/az (wrapper sets PYTHONWARNINGS=ignore)

    Multiple versions can coexist side-by-side. Previous versions are preserved automatically.

    To remove old versions:
      sudo /usr/local/microsoft/azure-cli/cleanup-old-versions.sh

    To manually switch versions (advanced):
      sudo ln -sf /usr/local/microsoft/azure-cli/<version> /usr/local/microsoft/azure-cli/current
      Example: sudo ln -sf /usr/local/microsoft/azure-cli/2.80.0 /usr/local/microsoft/azure-cli/current

    To verify installation:
      az --version
      ls -la /usr/local/microsoft/azure-cli/

    For complete removal including all versions:
      brew uninstall --zap --cask azure-cli-pr2
  EOS
end
