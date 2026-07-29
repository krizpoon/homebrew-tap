class Copybara < Formula
  desc "CLI for Copybara clipboard sync — post text and files to streams via iCloud"
  homepage "https://github.com/krizpoon/copybara"
  version "1.7.2"

  on_macos do
    url "https://github.com/krizpoon/copybara-releases/releases/download/v1.7.2/copybara-app.zip"
    sha256 "27aca997229c78fdb132fe857fab0fd744de4fc83cc66b2c811cc4c564e94018"
  end

  def install
    # Keep the .app bundle intact so the embedded provisioning profile
    # (required for CloudKit/iCloud access) remains valid at runtime.
    libexec.install "copybara.app"
    bin.write_exec_script libexec/"copybara.app/Contents/MacOS/copybara"
    bin.install_symlink bin/"copybara" => "cb"
  end

  # Event-driven hook watching: `brew services start copybara`.
  # Runs the app binary directly (not the bin exec-script) so the process keeps
  # its .app bundle identity + embedded provisioning profile — required for the
  # push entitlement. keep_alive because macOS won't relaunch a quit agent on a
  # CloudKit push. Runs as a user agent (needs the user's iCloud session), not
  # root. See docs/push-hooks.md; needs a build signed with the push profile.
  service do
    run [opt_libexec/"copybara.app/Contents/MacOS/copybara", "watch", "--push"]
    keep_alive true
    log_path var/"log/copybara-watch.log"
    error_log_path var/"log/copybara-watch.err.log"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/copybara help")
  end
end
