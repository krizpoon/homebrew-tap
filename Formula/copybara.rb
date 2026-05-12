class Copybara < Formula
  desc "CLI for Copybara clipboard sync — post text and files to streams via iCloud"
  homepage "https://github.com/krizpoon/copybara"
  version "1.0.0"

  on_macos do
    url "https://github.com/krizpoon/copybara/releases/download/v1.0.0/copybara.zip"
    sha256 "e90f73e86b454aa08c06996a2029a5a9becf535b62495348be3c6720fa4f2a6f"
  end

  def install
    bin.install "copybara"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/copybara help")
  end
end
