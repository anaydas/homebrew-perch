cask "perch" do
  version "0.2.1"
  sha256 "6e8e2b543762b63938a3a21b5d9d87890b8bf10247fd9436d322c531a960b395"

  url "https://github.com/anaydas/perch/releases/download/v#{version}/Perch-#{version}.zip"
  name "Perch"
  desc "Shelf for screenshots, text and files in the notch"
  homepage "https://github.com/anaydas/perch"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Perch.app"

  # Perch isn't notarized yet: clear the download flag so macOS doesn't block it on first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Perch.app"]
  end

  uninstall quit: "com.anaydas.Perch"

  zap trash: [
    "~/Library/Application Support/Perch",
    "~/Library/Preferences/com.anaydas.Perch.plist",
  ]
end
