require 'spec_helper'

describe 'easyrsa::cert' do
  let(:title) { 'we-really-dont-care' }

  let(:params) do
    {
      common_name: 'Test Certificate',
      easyrsadir: '/path/to/easyrsa',
      user: 'bloub',
      group: 'bloub'
    }
  end

  it { is_expected.to contain_exec('/path/to/easyrsa/easyrsa build-server-full "Test Certificate" nopass') }
end
