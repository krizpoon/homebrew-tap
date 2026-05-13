class Copybara < Formula
  desc "CLI for Copybara clipboard sync — post text and files to streams via iCloud"
  homepage "https://github.com/krizpoon/copybara"
  version "1.2.0"

  on_macos do
    url "https://github.com/krizpoon/copybara-releases/releases/download/v1.2.0/copybara-app.zip"
    sha256 "93ffbba8943eae40bf385237d164292b07939c0a3a780a1276e6b3932bf2390a"
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
