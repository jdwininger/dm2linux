#!/usr/bin/env bash
set -euo pipefail

# Build an RPM for the dm2 kernel module on Fedora/RHEL
# Requires: rpm-build, gcc, make, kernel-devel

PKG=dm2
VER=1.0
TARBALL=${PKG}-${VER}.tar.gz

echo "Preparing source tarball..."
rm -f "$TARBALL"
git archive --format=tar --prefix=${PKG}-${VER}/ HEAD | gzip > "$TARBALL"

echo "Building RPM with rpmbuild -ta $TARBALL"
rpmbuild -ta "$TARBALL" --define "_topdir ${HOME}/rpmbuild"

echo "RPM build complete. Check ~/rpmbuild/RPMS/ for generated packages."
