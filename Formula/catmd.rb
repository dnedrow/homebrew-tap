class Catmd < Formula
  desc "cat for Markdown: render Markdown as styled text in the terminal"
  homepage "https://github.com/dnedrow/catmd"
  version "0.1.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.10/catmd-aarch64-apple-darwin.tar.xz"
      sha256 "a7cdaa75d6cd69c7d2ed9c10cb363cdccd751af821c2ed5db57733364b81bd14"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.10/catmd-x86_64-apple-darwin.tar.xz"
      sha256 "c0038d140b04d7145d5dba32bda20676e342a610e720a80b08dae1452c238afb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.10/catmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2acb13d8ad2a40c7507afd95cb260c1c8af4d0af4b6f75cba38b7ccc1c51316e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/dnedrow/catmd/releases/download/v0.1.10/catmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b52a485bada8cf638d7d91eebc9716220d67b80d6edd97e3605ea67e7efa08d9"
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
