Name:           akmod-dm2
Version:        1.0
Release:        1%{?dist}
Summary:        Akmod package for Mixman DM2 kernel module

License:        GPLv2
URL:            https://sourceforge.net/projects/dm2/
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  gcc, make, rpm-build, akmods, kmod
Requires:       akmods

%description
This package provides an akmod-style package for the Mixman DM2 kernel
module. Installing this RPM on Fedora/RHEL systems will allow `akmods`
to automatically build the DM2 kernel module for new kernels when they
are installed.

%prep
%setup -q

%build
# akmods/kmods does the build at install-time / via akmods; nothing to do
# at build time for this source-only package.

%install
rm -rf %{buildroot}
# Put the source in a location where akmods can find it; this keeps things
# simple and avoids kmod build macros in this template.
mkdir -p %{buildroot}/usr/src/akmods/%{name}-%{version}
cp -a * %{buildroot}/usr/src/akmods/%{name}-%{version}/
mkdir -p %{buildroot}%{_sysconfdir}/udev/rules.d
install -m 0644 debian/udev/99-dm2.rules %{buildroot}%{_sysconfdir}/udev/rules.d/99-dm2.rules

%files
%defattr(-,root,root,-)
/usr/src/akmods/%{name}-%{version}
%config(noreplace) %{_sysconfdir}/udev/rules.d/99-dm2.rules
%doc README FEDORA.md

%post
echo "akmod-dm2 installed. To force build for the current kernel run:"
echo "  sudo akmods --force"

%changelog
* Thu Dec 17 2025 Your Name <you@example.com> - 1.0-1
- Initial akmod package template
