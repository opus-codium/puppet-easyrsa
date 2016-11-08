define easyrsa::ca (
  $common_name,
  $user,
  $group,
) {

  $ca   = "${title}/pki/ca.crt"
  $crl  = "${title}/pki/crl.pem"
  $dh   = "${title}/pki/dh.pem"

  # For better security, the easyrsa scripts are installed as root.
  file { $title:
    ensure  => directory,
    recurse => true,
    owner   => 'root',
    group   => 'root', # FIXME: FreeBSD use wheel
    source  => 'puppet:///modules/easyrsa/easyrsa3',
  }

  # Init the PKI as root (because we need to write in the easy-rsa directory);
  # Set the owner to openvpn
  # Run all other commands as openvpn
  exec { "${title}/easyrsa init-pki":
    cwd     => $title,
    creates => "${title}/pki",
    path    => '/bin:/usr/bin',
  }
  ->
  file { "${title}/pki":
    ensure  => directory,
    recurse => true,
    owner   => $user,
    group   => $group,
  }
  ->
  exec { "${title}/easyrsa build-ca nopass":
    cwd         => $title,
    user        => $user,
    group       => $group,
    creates     => $ca,
    path        => '/bin:/usr/bin',
    environment => [
      'EASYRSA_BATCH=1',
      "EASYRSA_REQ_CN=${common_name}",
    ],
  }
  ->
  exec { "${title}/easyrsa gen-dh":
    cwd     => $title,
    user    => $user,
    group   => $group,
    creates => $dh,
    path    => '/bin:/usr/bin',
    timeout => 3600,
  }
  ->
  exec { "${title}/easyrsa gen-crl":
    cwd     => $title,
    user    => $user,
    group   => $group,
    creates => $crl,
    path    => '/bin:/usr/bin',
  }
}
