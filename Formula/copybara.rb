class Copybara < Formula
  desc "CLI for Copybara clipboard sync — post text and files to streams via iCloud"
  homepage "https://github.com/krizpoon/copybara"
  version "2.1.2"

  on_macos do
    url "https://github.com/krizpoon/copybara-releases/releases/download/v2.1.2/copybara-app.zip"
    sha256 "78e419ccd05796d2a9098c4c631ed495e3534713ab89e8a5d9e77fd7cba1ed83"
  end

  def install
    # Keep the .app bundle intact so the embedded provisioning profile
    # (required for CloudKit/iCloud access) remains valid at runtime.
    libexec.install "copybara.app"
    bin.write_exec_script libexec/"copybara.app/Contents/MacOS/copybara"
    bin.install_symlink bin/"copybara" => "cb"
  end

  def caveats
    <<~EOS
      Claude Code plugin — teaches an agent to post clips and set up hooks:
        /plugin marketplace add krizpoon/copybara-releases
        /plugin install copybara@copybara

      Run hooks in the background (a command per arriving clip):
        brew services start krizpoon/tap/copybara
    EOS
  end

  # Hook watching: `brew services start copybara`.
  # Runs the app binary directly (not the bin exec-script) so the process keeps
  # its .app bundle identity + embedded provisioning profile — required for the
  # push entitlement. keep_alive because macOS won't relaunch a quit agent on a
  # CloudKit push. Runs as a user agent (needs the user's iCloud session), not
  # root. See docs/push-hooks.md; needs a build signed with the push profile.
  #
  # No --push: watching always registers for push and polls behind it, and the
  # agent tightens the poll by itself if registration fails. The flag was
  # removed in the CLI release this formula points at — keep_alive means a plist
  # that outruns the binary respawns a failing agent every few seconds, so this
  # line and the version above must move together.
  service do
    run [opt_libexec/"copybara.app/Contents/MacOS/copybara", "hook", "watch"]
    keep_alive true
    log_path var/"log/copybara-watch.log"
    error_log_path var/"log/copybara-watch.err.log"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/copybara help")
  end
end
