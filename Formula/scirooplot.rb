class Scirooplot < Formula
  desc "Scientific plotting framework based on ROOT"
  license "GPL-3.0-or-later"
  version "2.0.0"
  homepage "https://github.com/SciRooPlot/SciRooPlot"
  url "#{homepage}/archive/refs/tags/v#{version}.tar.gz"
  sha256 "<0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5>"

  depends_on "cmake"
  depends_on "python"
  depends_on "fmt"
  depends_on "boost"

  def install
    opoo <<~EOS
      SciRooPlot requires ROOT.

      If needed install via Homebrew:
        brew install root

      Or ensure an existing ROOT installation is active:
        source /path/to/root/bin/thisroot.sh
    EOS
    
    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
           *std_cmake_args

    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    <<~EOS
        Put the following line in your .zshrc to activate SciRooPlot:
          source $(brew --prefix scirooplot)/share/scirooplot/scirooplot-env.sh
    EOS
  end
end
