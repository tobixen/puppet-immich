require 'spec_helper'

describe 'immich' do
  let(:params) do
    {
      db_password: 'test_password',
    }
  end

  context 'on Arch Linux' do
    let(:facts) do
      {
        kernel: 'Linux',
        os: {
          'family' => 'Archlinux',
          'name' => 'Archlinux',
        },
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('immich::install::archlinux') }
    it { is_expected.to contain_class('immich::config') }
    it { is_expected.to contain_class('immich::service') }
    it { is_expected.to contain_package('immich-server').with_provider('yay') }
    it { is_expected.to contain_service('immich').with_ensure('running') }
  end

  context 'on Ubuntu' do
    let(:facts) do
      {
        kernel: 'Linux',
        os: {
          'family' => 'Debian',
          'name' => 'Ubuntu',
          'release' => {
            'major' => '22',
            'full' => '22.04',
          },
        },
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('immich::install::debian') }
  end
end
