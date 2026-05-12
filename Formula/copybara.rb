class Copybara < Formula
  desc "CLI for Copybara clipboard sync — post text and files to streams via iCloud"
  homepage "https://github.com/krizpoon/copybara"
  version "1.0.0"

  on_macos do
    url "https://github.com/krizpoon/copybara-releases/releases/download/v1.0.0/copybara-app.zip"
    sha256 "04428b161da378dcc240f793ed7d90923593f11df7841b8afba2d9bc68015c05"
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
