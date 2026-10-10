cask "zeltro" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0-beta.20"
  sha256 arm:   "272f1dc74865695a61be09e15511db634df69f31510ae874de5f6fc678c33641",
         intel: "46cbba32c710e972f0b5a519cd57971436b7ab4ec16d00539881735333b6976f"

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
