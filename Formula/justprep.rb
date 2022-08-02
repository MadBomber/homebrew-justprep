class Justprep < Formula
  desc "Pre-processor to the 'just' command-line utility"
  homepage "https://github.com/madbomber/justprep"
  url "https://github.com/madbomber/justprep/archive/refs/tags/v1.2.4.14.tar.gz"
  sha256 "bc031467bf2b6be227b80f18331257eb143baa994a106c65fb46372ed740c06f"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "df2cf86c253f460bfd8946b308e7b55fbf543e9b794b329c28bfda75258f35f8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4101ad9fbeb30cf08e47c97ef125254fc95a6dbc6f67d331eae37d5adfe20438"
    sha256 cellar: :any_skip_relocation, monterey:       "a9e7d7744d50642800d30fd71bd1186969afa62c7bbb1acab00449f2e7d8d51c"
    sha256 cellar: :any_skip_relocation, big_sur:        "9f2cdddfff055157be9642a70d0d3feee46ce378019e50cd4d00bdc0b01e8fa7"
    sha256 cellar: :any_skip_relocation, catalina:       "8db7da8d57c737df68d636c10fb92c4e9134057ff74e381f33cd3995fc0df2e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3b964ce56de96ac15559c5fa7b6bf58df83fe5972bc1b54c1519b436b72a3018"
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
