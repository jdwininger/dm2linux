Name:           kmod-dm2
Version:        1.0
Release:        1%{?dist}
Summary:        Kernel module package for Mixman DM2

License:        GPLv2
URL:            https://sourceforge.net/projects/dm2/
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  gcc, make, kernel-devel, rpm-build, kmod, kmod-macros
Requires:       kmod

%description
Builds the DM2 kernel module using the kmod build macros so it is
packaged in the standard kmod format for Fedora/RHEL systems.

%prep
%setup -q

%build
%kmod_build

%install
%kmod_install
mkdir -p %{buildroot}%{_sysconfdir}/udev/rules.d
install -m 0644 debian/udev/99-dm2.rules %{buildroot}%{_sysconfdir}/udev/rules.d/99-dm2.rules

%files
%defattr(-,root,root,-)
%{_libdir}/modules/*/dm2.ko
%config(noreplace) %{_sysconfdir}/udev/rules.d/99-dm2.rules

%changelog
* Thu Dec 17 2025 Jeremy Wininger <jeremy@example.com> - 1.0-1
- Package DM2 kernel module using kmod macros
