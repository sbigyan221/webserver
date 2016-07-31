class site::profiles::gitcode {
	
	package{ 'git':
		ensure => present,
	}

	vcsrepo { '/tmp/code/':
		ensure   => latest,
  		provider => git,
		owner    => root,
		group    => root,		
		source   => 'git@github.com:sbigyan221/webserver.git',
		revision => 'master',
		notify   => Exec['copy code'],
		before   => Exec['copy code'],
	}

	exec { 'copy code':
		command => '/bin/cp -rf /tmp/code/webcode/* /var/www/html/',
		notify  => Service['httpd'],
	}
}
