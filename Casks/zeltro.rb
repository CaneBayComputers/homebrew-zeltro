cask "zeltro" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0-beta.17"
  sha256 arm:   "9c9d527319b8cc2706293bfc5a7673fcccc203fbe36e8a2d4cc41147a7a5e661",
         intel: "f36e59ccd4cf1234cec270afc28f4e19a0124d20c5b439a4ad31a1cb965f6812"

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
