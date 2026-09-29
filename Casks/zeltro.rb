cask "zeltro" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0-beta.7"
  sha256 arm:   "3096eca51e88237764b5ebd657b2cd7677fbb590ec803542831070496c267d01",
         intel: "bba4dcabc8051046b765eeac7550678b16600bb819756f847e0c161ab60d9ac5"

  url "https://github.com/CaneBayComputers/zeltro-releases/releases/download/v#{version}/Zeltro-#{version}-mac-#{arch}.zip",
      verified: "github.com/CaneBayComputers/zeltro-releases/"
  name "Zeltro"
  desc "Build and run projects with AI"
  homepage "https://zeltro.build/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "Zeltro.app"

  # The app is not signed with an Apple Developer ID yet. Clearing the download
  # flag lets it open without Gatekeeper's "unidentified developer" block.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Zeltro.app"]
  end

  zap trash: [
    "~/Library/Application Support/zeltro-gui",
    "~/Library/Logs/zeltro-gui",
    "~/Library/Preferences/com.canebaycomputers.zeltro.plist",
    "~/Library/Saved Application State/com.canebaycomputers.zeltro.savedState",
  ]
end
