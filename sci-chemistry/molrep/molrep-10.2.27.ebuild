# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="molecular replacement program"
HOMEPAGE="http://www.ysbl.york.ac.uk/~alexei/molrep.html"
SRC_URI="http://dev.gentooexperimental.org/~jlec/science-dist/${P}.tar.gz"

LICENSE="ccp4"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND=">=sci-libs/ccp4-libs-6.1.1"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-respect-FLAGS.patch
}

src_compile() {
	cd "${S}"/src
	emake \
		MR_FORT=$(tc-getFC) \
		FFLAGS="${FFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		MR_LIBRARY="-lccp4f -lccp4c -lmmdb -lccif -L/usr/lib64 -llapack -lstdc++ -lm" \
	|| die
}

src_test() {
	cd molrep_check && \
		em.bat && \
		mr.bat || \
		die "test failed"
}

src_install() {
	dobin bin/${PN} || die

	dodoc readme doc/${PN}.rtf || die
}
