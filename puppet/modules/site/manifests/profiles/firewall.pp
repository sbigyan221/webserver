class site::profiles::firewall {
	resources { 'firewall':
    		purge => true,
  	}

  	Firewall {
     		require => Class['site::profiles::firewall_pre'],
     		before  => Class['site::profiles::firewall_post'],
  	}

  	class { '::firewall': }
  	class { 'site::profiles::firewall_pre': }
  	class { 'site::profiles::firewall_post': }
}

class site::profiles::firewall_pre {
  	Firewall {
     		require => undef,
  	}

   	# Default firewall rules
  	firewall { '000 accept all icmp':
     		proto  => 'icmp',
     		action => 'accept',
  	}

  	firewall { '001 accept all to lo interface':
     		proto   => 'all',
     		iniface => 'lo',
     		action  => 'accept',
  	}

  	firewall { '002 accept related established rules':
     		proto  => 'all',
     		state  => ['RELATED', 'ESTABLISHED'],
     		action => 'accept',
  	}

  	firewall { '003 accept all from 10.0.0.0/8':
     		proto  => 'tcp',
     		action => 'accept',
     		source => '10.0.0.0/8',
  	}

	firewall { '100 allow Puppet master access':
                dport   => '8140',
                proto  => tcp,
                action => accept,
        }

	firewall { '100 allow Puppet client access':
                dport   => '8141',
                proto  => tcp,
                action => accept,
        }

	firewall { '100 allow Puppet  access':
                dport   => '822',
                proto  => tcp,
                action => accept,
        }

	firewall { '80 Allow http access ':
                dport   => '80',
                proto  => tcp,
                action => accept,
        }

	firewall { '100 Allow https access ':
                dport   => '443',
                proto  => tcp,
                action => accept,
        }


  	firewall { '100 Allow ssh access ':
    		dport   => '22',
    		proto  => tcp,
    		action => accept,
  	}


}

class site::profiles::firewall_post {
 	firewall { '999 drop all':
   		proto  => 'all',
   		action => 'drop',
   		before => undef,
 }

}
