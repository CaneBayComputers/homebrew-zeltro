cask "zeltro" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0-beta.32"
  sha256 arm:   "2a2561cdec85ab23a66adea2e8f2e765549d3829ee8054b15b27e21286aabe54",
         intel: "869424b3a14e2f622240ac3f95dafde61a6bb51f19237fafa4353a304ec0dcb4"

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
