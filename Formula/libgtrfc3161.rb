class Libgtrfc3161 < Formula
  desc "SDK for converting Guardtime's legacy signatures to Guardtime's KSI signatures"
  homepage "https://github.com/guardtime/libgtrfc3161"
  url "https://github.com/guardtime/libgtrfc3161/archive/v1.1.78.tar.gz"
  sha256 "055a083e4a0dc6234c31f6a3aeb8f6712151751a1936853e1c58da5233138e1f"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libksi"

  # Change revision if there is a need to recompile the formula
  # and the version of the package is not changed. If version
  # changes comment 'revision' field out.
  revision 1

  def install
    system "autoreconf", "-if"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <gtrfc3161/parseasn1>
      #include <assert.h>
      int main()
      {
        asn1_dom *dom = NULL;
        assert(asn1_dom_new(1024, &dom) == LEGACY_OK);
        asn1_dom_free(dom);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}",
                   "-lksi", "-lgtrfc3161", "-o", "test"
    system "./test"
  end
end
