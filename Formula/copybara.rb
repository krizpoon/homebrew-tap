class Copybara < Formula
  desc "CLI for Copybara clipboard sync — post text and files to streams via iCloud"
  homepage "https://github.com/krizpoon/copybara"
  version "1.4.1"

  on_macos do
    url "https://github.com/krizpoon/copybara-releases/releases/download/v1.4.1/copybara-app.zip"
    sha256 "2c89c90f08a8d612cc9282f797a6bb1b661253567644fc489428931db38e9216"
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
