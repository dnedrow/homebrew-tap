class Catmd < Formula
  desc "cat for Markdown: render Markdown as styled text in the terminal"
  homepage "https://github.com/dnedrow/catmd"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dnedrow/catmd/releases/download/v0.2.0/catmd-aarch64-apple-darwin.tar.xz"
      sha256 "a6f41a130855de560285264494f03ef07c9a80a2b87bafec5aeade5be9c59a1a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dnedrow/catmd/releases/download/v0.2.0/catmd-x86_64-apple-darwin.tar.xz"
      sha256 "1ee3fe25b7cc3f88f8ec847cf2610043776efc71400b202a7bfbc5967b1b1fee"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dnedrow/catmd/releases/download/v0.2.0/catmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "52966fd74293a8ff5b66440019e2d82f377921e0b3996e7808ea56b30591d65e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dnedrow/catmd/releases/download/v0.2.0/catmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6df51881a661c85c1e3c658b21651ac4d4c424f6962c4627cf4d8dd105ed570a"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "catmd"
      man1.install "catmd.1" if File.exist?("catmd.1")
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "catmd"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "catmd"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "catmd"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
