class Catmd < Formula
  desc "cat for Markdown: render Markdown as styled text in the terminal"
  homepage "https://github.com/dnedrow/catmd"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.8/catmd-aarch64-apple-darwin.tar.xz"
      sha256 "295f73b36f8e882e60b8656ef8e9997d3141d311ca60bea1eec5b124b882950d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.8/catmd-x86_64-apple-darwin.tar.xz"
      sha256 "bf259f1afcccd6264096b3e76c51f1bfff8a508b06d4bf16a05b8277734fc161"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.8/catmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "48883e7fc6df81ff39e8d3531021713934b3bc800ceaf02d2f292bd1f5e67354"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.8/catmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "713a6a6ef721d84d0fdafb8007b6e15d511ca7de887bdbd27e4c6f17c190172c"
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

    man1.install "catmd.1" if File.exist?("catmd.1")
    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
