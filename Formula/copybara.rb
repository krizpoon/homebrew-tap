class Copybara < Formula
  desc "CLI for Copybara clipboard sync — post text and files to streams via iCloud"
  homepage "https://github.com/krizpoon/copybara"
  version "1.3.0"

  on_macos do
    url "https://github.com/krizpoon/copybara-releases/releases/download/v1.3.0/copybara-app.zip"
    sha256 "bafbdd72772ad1580b47b6442df2b750892cdff6102d28163c9c71d7034119b1"
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
