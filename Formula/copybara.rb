class Copybara < Formula
  desc "CLI for Copybara clipboard sync — post text and files to streams via iCloud"
  homepage "https://github.com/krizpoon/copybara"
  version "1.5.0"

  on_macos do
    url "https://github.com/krizpoon/copybara-releases/releases/download/v1.5.0/copybara-app.zip"
    sha256 "735179ba7cae8ae31afd46cd2cc9bd0dd66b1f3703101de61a155fc96690dec9"
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
