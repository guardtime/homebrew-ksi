class Libparamset < Formula
  desc "C SDK for handling command-line parameters and program tasks"
  homepage "https://github.com/guardtime/libparamset"
  url "https://github.com/guardtime/libparamset/archive/v1.1.240.tar.gz"
  sha256 "fe7f3216c62cc52f5379a9a2d2b58bb34dc64c33d29bedc1c4b77783699d2cf2"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "-if"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <param_set/param_set.h>
      #include <assert.h>
      int main()
      {
        PARAM_SET *set = NULL;
        assert(PARAM_SET_new("{h|help}{version}{d}", &set) == PST_OK);
        PARAM_SET_free(set);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}",
                   "-lparamset", "-o", "test"
    system "./test"
  end
end
