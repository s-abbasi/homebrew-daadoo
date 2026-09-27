# Homebrew cask for the Daadoo desktop agent. Lives in the public tap repo
# s-abbasi/homebrew-daadoo as Casks/daadoo.rb; this copy is its source of
# truth. `bun run release:macos` rewrites version and sha256 below.
cask "daadoo" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "26e99b9c48f0109f26c37d5572cf44bac445f205c1edf73230ed0ec69632fe55",
         intel: "9f507dc69205b01f9332a3adf33757756f757c57b3effc3165d0d40647695ab5"

  url "https://github.com/s-abbasi/homebrew-daadoo/releases/download/v#{version}/daadoo_#{version}_#{arch}.dmg"
  name "Daadoo"
  desc "Desktop agent that runs Daadoo LinkedIn campaigns from your own machine"
  homepage "https://github.com/s-abbasi/homebrew-daadoo"

  depends_on macos: ">= :big_sur"

  app "daadoo.app"

  # The app is ad-hoc signed, not notarized (no Apple Developer ID), so
  # Gatekeeper would block the first launch of a quarantined download.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/daadoo.app"]
  end

  uninstall quit: "com.daadoo.local-agent"

  zap trash: [
    "~/Library/Application Support/com.daadoo.local-agent",
    "~/Library/Caches/com.daadoo.local-agent",
    "~/Library/Logs/com.daadoo.local-agent",
    "~/Library/WebKit/com.daadoo.local-agent",
  ]

  caveats <<~EOS
    Daadoo drives your installed Google Chrome, so Chrome must be installed:
      brew install --cask google-chrome

    Daadoo is not notarized by Apple. This cask removes the download
    quarantine flag so it opens without a Gatekeeper prompt.
  EOS
end
