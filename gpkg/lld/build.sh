TERMUX_PKG_HOMEPAGE=https://llvm.org/
TERMUX_PKG_DESCRIPTION="Linker from the LLVM project"
TERMUX_PKG_LICENSE="Apache-2.0, NCSA"
TERMUX_PKG_LICENSE_FILE="LICENSE.TXT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=17.0.6
_SOURCE=https://github.com/llvm/llvm-project/releases/download/llvmorg-$TERMUX_PKG_VERSION
TERMUX_PKG_SRCURL=($_SOURCE/lld-$TERMUX_PKG_VERSION.src.tar.xz
		$_SOURCE/llvm-$TERMUX_PKG_VERSION.src.tar.xz
		$_SOURCE/libunwind-$TERMUX_PKG_VERSION.src.tar.xz
                $_SOURCE/cmake-$TERMUX_PKG_VERSION.src.tar.xz)
TERMUX_PKG_SHA256=(4ac13125616dc44905b85820aa403d27ec1226329b7f674daeb5f5584c6f0b22
                b638167da139126ca11917b6880207cc6e8f9d1cbb1a48d87d017f697ef78188
                9e7535a353aa862730b4ba38df42e06f6856b40c4cc51b57f27b5046dc21d70d
		807f069c54dc20cb47b21c1f6acafdd9c649f3ae015609040d6182cab01140f4)
TERMUX_PKG_DEPENDS="libllvm-glibc, gcc-libs-glibc, zlib-glibc, zstd-glibc"
TERMUX_PKG_BUILD_DEPENDS="llvm-glibc"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DLLVM_HOST_TRIPLE=$TERMUX_HOST_PLATFORM
-DCMAKE_LIBRARY_ARCHITECTURE=$TERMUX_HOST_PLATFORM
-DCMAKE_INSTALL_DOCDIR=share/doc
-DCMAKE_SKIP_RPATH=ON
-DBUILD_SHARED_LIBS=ON
-DLLVM_BUILD_DOCS=ON
-DLLVM_ENABLE_SPHINX=ON
-DLLVM_EXTERNAL_LIT=$TERMUX_PREFIX/bin/lit
-DLLVM_MAIN_SRC_DIR=$TERMUX_TOPDIR/$TERMUX_PKG_NAME/llvm
-DLLVM_INCLUDE_TESTS=OFF
-DLLVM_LINK_LLVM_DYLIB=ON
-DSPHINX_WARNINGS_AS_ERRORS=OFF
"

termux_step_post_get_source() {
	for i in llvm libunwind cmake; do
		rm -fr $TERMUX_TOPDIR/$TERMUX_PKG_NAME/${i}
		mv $TERMUX_PKG_SRCDIR/$i-$TERMUX_PKG_VERSION.src $TERMUX_TOPDIR/$TERMUX_PKG_NAME
		mv $TERMUX_TOPDIR/$TERMUX_PKG_NAME/$i-$TERMUX_PKG_VERSION.src $TERMUX_TOPDIR/$TERMUX_PKG_NAME/$i
        done
}

termux_step_pre_configure() {
	local LLVM_TARGET_ARCH="X86"
	if [ $TERMUX_ARCH = "arm" ]; then
		LLVM_TARGET_ARCH="ARM"
	elif [ $TERMUX_ARCH = "aarch64" ]; then
		LLVM_TARGET_ARCH="AArch64"
	fi

	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_SYSTEM_PROCESSOR=${LLVM_TARGET_ARCH}"
}