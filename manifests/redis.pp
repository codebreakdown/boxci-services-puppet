class boxci::redis {
  file { '/var/lib/redis':
    ensure => 'directory',
    owner  => $vagrant_user,
    group  => $vagrant_user,
    before => Package['redis-server']
  }

  package { 'redis-server':
    ensure => latest,
    name   => 'redis-server',
    before => File['/etc/redis/redis.conf'],
  }

  file { "/etc/redis/redis.conf":
    ensure  => 'file',
    owner   => 'root',
    mode    => '0644',
    source  => "puppet:///modules/boxci/redis.conf",
  }

  service { 'redis-server':
    enable     => true,
    hasrestart => true,
    subscribe => File['/etc/redis/redis.conf'],
  }
}
