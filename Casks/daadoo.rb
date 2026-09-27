# Template for the Daadoo cask. The live copy is Casks/daadoo.rb in the public
# tap s-abbasi/homebrew-daadoo, which its release workflow overwrites with this
# file after `bun run release:macos` rewrites the version and sha256 below.
cask "daadoo" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.1"
  sha256 arm:   "58c408d82db2ed9148891af4dadbe050395c5b55cd1361e4b81e73e7d8c714bf",
         intel: "aa0b845782168cef78a4831ecf6cf0a1879a7a1ac047fb10393fc78d0a3953ce"

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
