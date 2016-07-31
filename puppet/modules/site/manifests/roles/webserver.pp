class site::roles::webserver {
	include site::profiles::httpd
	include site::profiles::gitcode
	include site::profiles::firewall

}
