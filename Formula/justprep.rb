class Justprep < Formula
  desc "Pre-processor to the 'just' command-line utility"
  homepage "https://github.com/madbomber/justprep"
  url "https://github.com/madbomber/justprep/archive/refs/tags/v1.2.4.14.tar.gz"
  sha256 "bc031467bf2b6be227b80f18331257eb143baa994a106c65fb46372ed740c06f"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/madbomber/justprep"
  end

  depends_on "crystal"  => :build
  depends_on "just"     => :build

  depends_on "bdw-gc"
  depends_on "libevent"
  depends_on "pcre"

  def install
    system "just", "crystal/build"
    bin.install "./crystal/bin/justprep"
  end

  test do
    (testpath/"include_me.just").write <<~EOS
      default:
        touch it-worked
    EOS

    (testpath/"main.just").write <<~EOS
      include ./include_me.just
    EOS

    system bin/"justprep"
    assert_predicate testpath/"justfile", :exist?

    system bin/"just"
    assert_predicate testpath/"it-worked", :exist?
  end
end
