
class envconsul (
    $ensure     = 'present',
    $version    = '0.5.0'
) {

    $url = "https://www.github.com/hashicorp/envconsul/releases/download/v${version}/envconsul_${version}_linux_amd64.tar.gz"

    staging::file { 'envconsul.tar.gz':
        source => $url,
    } ->
    staging::extract { 'envconsul.tar.gz':
        strip   => 0,
        target  => "/opt",
        creates => "/opt/envconsul_${version}_linux_amd64",
    } ->
    file { "/opt/hashicorp/envconsul_${version}_linux_amd64/envconsul":
        ensure => file,
        owner  => root,
        group  => root,
        mode   => '0555',
    } ->
    file { "/usr/local/bin/envconsul":
        ensure => "link",
        target => "/opt/envconsul_${version}_linux_amd64/envconsul",
    }
}
