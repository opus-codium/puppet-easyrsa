require 'spec_helper'

describe 'easyrsa::ca' do
  let(:title) { '/path/to/easyrsa' }

  let(:params) do
    {
      common_name: 'Test CA',
      user: 'bloub',
      group: 'bloub',
    }
  end

  it { is_expected.to contain_file('/path/to/easyrsa').with(ensure: 'directory', owner: 'root', group: 'root') }
  it { is_expected.to contain_file('/path/to/easyrsa/pki').with(ensure: 'directory', owner: 'bloub', group: 'bloub') }
  it { is_expected.to contain_exec('/path/to/easyrsa/easyrsa init-pki') }
  it { is_expected.to contain_exec('/path/to/easyrsa/easyrsa build-ca nopass') }
  it { is_expected.to contain_exec('/path/to/easyrsa/easyrsa gen-dh') }
  it { is_expected.to contain_exec('/path/to/easyrsa/easyrsa gen-crl') }
end
