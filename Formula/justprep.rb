class Justprep < Formula
  desc "Pre-processor to the 'just' command-line utility"
  homepage "https://github.com/madbomber/justprep"
  url "https://github.com/madbomber/justprep/archive/refs/tags/v1.2.4.14.tar.gz"
  sha256 "bc031467bf2b6be227b80f18331257eb143baa994a106c65fb46372ed740c06f"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "891e110314f0704e3dfdc03b53a6d2fd059ddb444d25834713ca0b9dad1bb489"  
    # justprep-v1.2.4.14-aarch64-unknown-linux-gnu.tar.gz

    # "80b97f8a98f1f98c7be55130d67f8401ac70787c1d27459b4a705ae9e7619892"  
    # justprep-v1.2.4.14-x86_64-unknown-linux-musl.tar.gz

    sha256 cellar: :any_skip_relocation, arm64_monterey:  "0dfe62d080b4a39574e2cb05ae4043860e5eb8890147b6f412fb66893d731bc7"  
    sha256 cellar: :any_skip_relocation, arm64_big_sur:   "0dfe62d080b4a39574e2cb05ae4043860e5eb8890147b6f412fb66893d731bc7"  
    # justprep-v1.2.4.14-arm64-apple-darwin.tar.

    sha256 cellar: :any_skip_relocation, monterey:    "b6bdb6eae7bc2bed021ba8e9e7fd3ffa7a8bc9317db535408b95c3380eaf18c6"  
    sha256 cellar: :any_skip_relocation, big_sur:     "b6bdb6eae7bc2bed021ba8e9e7fd3ffa7a8bc9317db535408b95c3380eaf18c6"  
    # justprep-v1.2.4.14-x86_64-apple-darwin.tar.gz
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
