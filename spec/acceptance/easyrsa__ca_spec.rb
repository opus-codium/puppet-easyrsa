require 'spec_helper_acceptance'

describe 'easyrsa::ca' do
  before(:all) do
    pp = <<-EOT
      easyrsa::ca { '/test-ca':
        common_name => 'TEST-CA',
        user        => 'nobody',
        group       => 'nogroup',
      }
    EOT

    apply_manifest(pp, catch_failures: true)
  end

  describe file('/test-ca') do
    it { should exist }
  end

  describe file('/test-ca/pki') do
    it { should exist }
  end

  context 'create certificate' do
    before(:all) do
      pp = <<-EOT
        easyrsa::cert { 'fixme-we-need-something-here':
          easyrsadir  => '/test-ca',
          common_name => 'TEST-CERT',
          user        => 'nobody',
          group       => 'nogroup',
        }
      EOT

      apply_manifest(pp, catch_failures: true)
    end

    describe file('/test-ca/pki/issued/TEST-CERT.crt') do
      it { should exist }
    end
    describe file('/test-ca/pki/private/TEST-CERT.key') do
      it { should exist }
    end
  end
end
