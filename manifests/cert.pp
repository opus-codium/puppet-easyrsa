# @summary Manage EasyRSA certificate
#
# @param common_name
# @param easyrsadir
# @param user
# @param group
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
