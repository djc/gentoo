# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit toolchain-funcs

DESCRIPTION="Canna Japanese kana-kanji frontend processor on console"
HOMEPAGE="http://www.geocities.co.jp/SiliconValley-Bay/7584/canfep/"
SRC_URI="http://www.geocities.co.jp/SiliconValley-Bay/7584/${PN}/${P}.tar.gz
	unicode? ( http://hp.vector.co.jp/authors/VA020411/patches/${PN}_utf8.diff )"

LICENSE="canfep"
SLOT="0"
KEYWORDS="-alpha ~amd64 ppc ~sparc x86"
IUSE="unicode"

RDEPEND="app-i18n/canna
	sys-libs/ncurses:="
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	use unicode && eapply "${DISTDIR}"/${PN}_utf8.diff
	sed -i 's/$(CFLAGS)/$(CFLAGS) $(LDFLAGS)/' Makefile

	default
}

src_compile() {
	emake \
		CC="$(tc-getCXX)" \
		LIBS="-lcanna $(pkg-config --libs ncurses)"
}

src_install() {
	dobin ${PN}
	dodoc 00{changes,readme}
}
