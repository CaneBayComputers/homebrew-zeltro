cask "zeltro" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0-beta.8"
  sha256 arm:   "e5ac11aff0843253b1c506fc3b2e72774de0d643714b2721b4fab2853f5add37",
         intel: "4f07e9cc06808b7cc900059fdd3c1d5ad5550092e40c35aa3a1a775d1b8a8bbd"

  url "https://github.com/CaneBayComputers/zeltro-releases/releases/download/v#{version}/Zeltro-#{version}-mac-#{arch}.zip"
  name "Zeltro"
  desc "Build and run projects with AI"
  homepage "https://zeltro.build/"

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
