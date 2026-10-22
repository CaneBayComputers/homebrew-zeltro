cask "zeltro" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0-beta.25"
  sha256 arm:   "28c47db5a44dc29b4726235c289978462ca69b510ffc8b9326aa99c465341742",
         intel: "96bfdc1eb41b2ba0dc5a7098334f2a39bb84dc4b0ecdc15fae605d8ec5676fab"

  url "https://github.com/CaneBayComputers/zeltro-releases/releases/download/v#{version}/Zeltro-#{version}-mac-#{arch}.zip"
  name "Zeltro"
  desc "Build and run projects with AI"
  homepage "https://zeltro.ai/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Zeltro.app"

  # The app is not signed with an Apple Developer ID yet. Clearing the download
  # flag lets it open without Gatekeeper's "unidentified developer" block.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Zeltro.app"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/zeltro-gui",
    "~/Library/Logs/zeltro-gui",
    "~/Library/Preferences/com.canebaycomputers.zeltro.plist",
    "~/Library/Saved Application State/com.canebaycomputers.zeltro.savedState",
  ]
end
