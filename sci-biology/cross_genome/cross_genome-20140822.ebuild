# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Genome scaffolding using cross-species synteny"
HOMEPAGE="http://www.sanger.ac.uk/science/tools/crossgenome"
SRC_URI="https://sourceforge.net/projects/phusion2/files/cross_genome/cross_genome.tar.gz -> cross_genome-20140822.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare(){
	sed -e 's/^CC =/# CC =/' -i Makefile || die
	sed -e 's/^CFLAGS =/# CFLAGS =/' -i Makefile || die
}

src_install(){
	dobin cross_genome.csh cross_genome
	dodoc README
}