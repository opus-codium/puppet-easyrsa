define easyrsa::cert (
  $common_name,
  $easyrsadir,
  $user,
  $group,
) {
  exec { "${easyrsadir}/easyrsa build-server-full \"${common_name}\" nopass":
    cwd     => $easyrsadir,
    user    => $user,
    group   => $group,
    creates => "${easyrsadir}/pki/issued/${common_name}.crt",
    path    => '/bin:/usr/bin',
  }
}
