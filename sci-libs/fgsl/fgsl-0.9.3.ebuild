# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils multilib toolchain-funcs

DESCRIPTION="A Fortran interface to the GNU Scientific Library"
HOMEPAGE="http://www.lrz.de/services/software/mathematik/gsl/fortran/"
SRC_URI="http://www.lrz.de/services/software/mathematik/gsl/fortran/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

DEPEND=">=sci-libs/gsl-1.14"
RDEPEND="${DEPEND}"
#TODO: make docs

src_prepare() {
	epatch "${FILESDIR}"/${P}-sharedlibs.patch
	use amd64 && ln -s interface/integer_ilp64.finc integer.finc
	use x86 && ln -s interface/integer_ilp32.finc integer.finc
	cat <<- EOF > "${S}/make.inc"
		F90 = $(tc-getFC)
		CC = $(tc-getCC)
		GSL_LIB = $(pkg-config --libs gsl)
		GSL_INC = $(pkg-config --cflags gsl)
		PREFIX = /usr
		ARFLAGS = -csrv
		FPP = -cpp
		LIB = $(get_libdir)
	EOF
	use static-libs && echo "STATIC_LIBS = yes" >> "${S}/make.inc"
}

src_configure() {
	return
}

src_install() {
	dodoc NEWS README || die
	ln -s lib${PN}.so.0.0.0 lib${PN}.so.0
	ln -s lib${PN}.so.0.0.0 lib${PN}.so
	dolib.so lib${PN}.so* || die
	insinto /usr/include
	doins ${PN}.mod || die
	if use static-libs ; then
		newlib.a lib${PN}_$(tc-getFC).a lib${PN}.a || die
	fi
}
