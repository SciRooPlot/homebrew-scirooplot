class Scirooplot < Formula
  desc "Scientific plotting framework based on ROOT"
  license "GPL-3.0-or-later"
  version "3.2.0"
  homepage "https://github.com/SciRooPlot/SciRooPlot"
  head "#{homepage}.git", branch: "master"
  url "#{homepage}/archive/refs/tags/v#{version}.tar.gz"
  sha256 "0fb3cd69a0eac90d5e98ebd344adcb2d6c149e2a87324eaae088c65bb0ee34dd"

  depends_on "cmake"
  depends_on "python"
  depends_on "pybind11"
  depends_on "fmt"
  depends_on "boost"
  depends_on "root"

  def install
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
