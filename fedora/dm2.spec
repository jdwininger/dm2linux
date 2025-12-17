Name:           dm2
Version:        1.0
Release:        1%{?dist}
Summary:        Mixman DM2 USB MIDI controller kernel module

License:        GPLv2
URL:            https://sourceforge.net/projects/dm2/
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  gcc, make, kernel-devel, rpm-build
Requires:       alsa-lib

%description
Builds the DM2 kernel module for Fedora/RHEL systems. The package
installs the kernel module into the kernel modules directory and
provides a udev rule to set permissions.

%prep
%setup -q

%build
make -C .

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}%{_libdir}/modules/%{kernel_version}
install -m 644 dm2.ko %{buildroot}%{_libdir}/modules/%{kernel_version}/dm2.ko
mkdir -p %{buildroot}%{_sysconfdir}/udev/rules.d
install -m 0644 debian/udev/99-dm2.rules %{buildroot}%{_sysconfdir}/udev/rules.d/99-dm2.rules

%files
%defattr(-,root,root,-)
%{_libdir}/modules/%{kernel_version}/dm2.ko
%config(noreplace) %{_sysconfdir}/udev/rules.d/99-dm2.rules

%changelog
* Thu Dec 17 2025 Your Name <you@example.com> - 1.0-1
- Initial rpm spec
