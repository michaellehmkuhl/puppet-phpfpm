define phpfpm::nginx::vhost (
	$vhost = $title,
	$root = '/var/www',
	$server_name = '_',
	$options = {},
) {
	
	include nginx

	file { "/etc/nginx/sites-available/${vhost}.conf":
		ensure 	=> file,
		content => template('phpfpm/nginx/vhost.conf.erb'),
		require => [
			File["/etc/nginx/sites-enabled/${vhost}.conf"],
		],
		notify 	=> Class['nginx::service'],
	}

	file { "/etc/nginx/sites-enabled/${vhost}.conf":
		ensure 	=> link,
		target 	=> "/etc/nginx/sites-available/${vhost}.conf",
		require => Class['nginx::install'],
	}

}