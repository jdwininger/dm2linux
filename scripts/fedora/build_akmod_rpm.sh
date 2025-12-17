#!/usr/bin/env bash
set -euo pipefail

# Build an akmod RPM for the dm2 driver

PKG=akmod-dm2
VER=1.0
TARBALL=${PKG}-${VER}.tar.gz

echo "Preparing source tarball for ${PKG}..."
rm -f "$TARBALL"
git archive --format=tar --prefix=${PKG}-${VER}/ HEAD | gzip > "$TARBALL"

echo "Building akmod RPM with rpmbuild -ta $TARBALL"
rpmbuild -ta "$TARBALL" --define "_topdir ${HOME}/rpmbuild"

echo "AKMOD RPM build complete. Check ~/rpmbuild/RPMS/ for generated packages."
echo "To install and force akmods to build the module for the currently running kernel:"
echo "  sudo dnf install -y ~/rpmbuild/RPMS/*/akmod-dm2-*.rpm"
echo "  sudo akmods --force && sudo dracut -f -v" 
