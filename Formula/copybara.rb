class Copybara < Formula
  desc "CLI for Copybara clipboard sync — post text and files to streams via iCloud"
  homepage "https://github.com/krizpoon/copybara"
  version "1.1.0"

  on_macos do
    url "https://github.com/krizpoon/copybara-releases/releases/download/v1.1.0/copybara-app.zip"
    sha256 "2828e939fc3eaaff81b6609d17d565585896fcb6a8d849744bf1405ccd2b2996"
  end

  def install
    # Keep the .app bundle intact so the embedded provisioning profile
    # (required for CloudKit/iCloud access) remains valid at runtime.
    libexec.install "copybara.app"
    bin.write_exec_script libexec/"copybara.app/Contents/MacOS/copybara"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/copybara help")
  end
end
