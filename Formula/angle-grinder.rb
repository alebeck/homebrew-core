class AngleGrinder < Formula
  desc "Slice and dice log files on the command-line"
  homepage "https://github.com/rcoh/angle-grinder"
  url "https://github.com/rcoh/angle-grinder/archive/v0.9.0.tar.gz"
  sha256 "230eb2bfbab73eb3ac5b37d25ab7521bc50f7640d9c12fcf50c3526eb4ba3423"

  bottle do
    cellar :any_skip_relocation
    sha256 "2490b6ba39c056bd6a819b3eccaf9f6193c05f7a2a493136d7dd930cfa3fa89c" => :mojave
    sha256 "2a209c1c0c71e06955acdd3a8d5f3ff37e3d433dba3d018504759049f3fd1eee" => :high_sierra
    sha256 "b654fa835ba288ab1d6153ef133e264258b7307fe056423a11c1ad9909e02b81" => :sierra
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--root", prefix, "--path", "."
  end

  test do
    (testpath/"logs.txt").write("{\"key\": 5}")
    output = shell_output("#{bin}/agrind --file logs.txt '* | json'")
    assert_match "[key=5]", output
  end
end
