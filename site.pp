node default {
	# Install cron to enforce hardening configuration
	$current_directory = inline_template('<%= Dir.pwd %>')
	cron { 'hardening':
		command => "$current_directory/run.sh",
		user    => 'root',
		hour    => 1,
		minute  => 0,
	}

	# Harden each security domain
	include ssh_hardening_config
	include os_hardening_config
	include firewall_config
}