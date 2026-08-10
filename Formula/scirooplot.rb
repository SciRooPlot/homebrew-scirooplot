class Scirooplot < Formula
  desc "A command-line plotting app to manage and visualize scientific data."
  license "GPL-3.0-or-later"

  version "3.2.4"
  homepage "https://github.com/SciRooPlot/SciRooPlot"
  head "#{homepage}.git", branch: "master"
  url "#{homepage}/archive/refs/tags/v#{version}.tar.gz"
  sha256 "885f72053d8fe12b5b2d500ecdbfb5961fe9a76a7e4162ed343bfb218b5b75e9"

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

  test do
    system bin/"srp", "info"
  end

  def caveats
    <<~EOS
      To activate SciRooPlot (best place it in ~/.zshrc or ~/.bashrc):

        source $(brew --prefix scirooplot)/share/scirooplot/scirooplot-env.sh
    EOS
  end
end
