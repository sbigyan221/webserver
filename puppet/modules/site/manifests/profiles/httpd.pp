class site::profiles::httpd {

	$application=["httpd","openssl","mod_ssl"]

	package { $application:
		ensure => present,
	}
	service { 'httpd':
		ensure  => running,
		enable  => true,
		require => Package['httpd'],
	}

	file { '/etc/httpd/conf/httpd.conf':
    		ensure  => file,
    		content => template('site/httpd/httpd.conf.erb'),
    		require => Package['httpd'],
		notify  => Service['httpd'],
  	}

	exec {'self_sign_ssl_certification':
  		command => "openssl req -newkey rsa:2048 -nodes -keyout ca.key  -x509 -days 365 -out ca.crt -subj '/CN=${::fqdn}'",
  		cwd     => "/tmp",
		onlyif  => ['/bin/ls /tmp/ | /bin/grep -c ca.key','/bin/ls /tmp/ | /bin/grep -c ca.crt'],
  		path    => ["/usr/bin", "/usr/sbin"],
	}

	exec { 'copy the ca1.key':
		command => '/bin/cp -rf /tmp/ca.key /etc/pki/tls/private/ca.key',
	}
	exec { 'copy the ca.crt':
                command => '/bin/cp -rf /tmp/ca.crt /etc/pki/tls/certs/ca.crt',
		notify => service['httpd'],
        }

}
