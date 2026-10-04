# Homebrew cask for the Daadoo desktop agent. Generated: the template is
# apps/local-agent/packaging/homebrew/Casks/daadoo.rb in s-abbasi/daadoo-app,
# and s-abbasi/homebrew-daadoo's release workflow fills in version and sha256
# and commits it there as Casks/daadoo.rb. Edit the template, not the tap copy.
cask "daadoo" do
  arch arm: "aarch64", intel: "x64"

  version "0.4.0"
  sha256 arm:   "c5e7b1356c6e1ce3e571c2281b0ce0c67c078ddd4c7dbce5e623cf14353cc833",
         intel: "c96491ec91830a0e3eb3675d0077c88bb48c62e5e518f26d591c755585e92103"

  url "https://github.com/s-abbasi/homebrew-daadoo/releases/download/v#{version}/daadoo_#{version}_#{arch}.dmg"
  name "Daadoo"
  desc "Desktop agent that runs Daadoo LinkedIn campaigns from your own machine"
  homepage "https://github.com/s-abbasi/homebrew-daadoo"

  # The app updates itself (tauri-plugin-updater), so `brew upgrade` leaves it
  # alone unless run with --greedy.
  auto_updates true
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
