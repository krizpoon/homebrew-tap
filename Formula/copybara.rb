class Copybara < Formula
  desc "CLI for Copybara clipboard sync — post text and files to streams via iCloud"
  homepage "https://github.com/krizpoon/copybara"
  version "1.4.0"

  on_macos do
    url "https://github.com/krizpoon/copybara-releases/releases/download/v1.4.0/copybara-app.zip"
    sha256 "56fbfc7c966884c56c67beb128da71ee59e3c97fbdb197e41507432bdc6fc909"
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
