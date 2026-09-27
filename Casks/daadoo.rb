# Homebrew cask for the Daadoo desktop agent. Generated: the template is
# apps/local-agent/packaging/homebrew/Casks/daadoo.rb in s-abbasi/daadoo-app,
# and s-abbasi/homebrew-daadoo's release workflow fills in version and sha256
# and commits it there as Casks/daadoo.rb. Edit the template, not the tap copy.
cask "daadoo" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.3"
  sha256 arm:   "5493ab9fb877d0979ec39af7dc922313042801553c8ad968a5ceec7b1af63a2f",
         intel: "66b51a174431c8568225f8c38224e8d578fef55e844c9157f6fafa45ebe7f9d7"

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
