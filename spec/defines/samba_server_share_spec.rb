#
#    Copyright (C) 2014 Niklaus Giger <niklaus.giger@member.fsf.org>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
require 'spec_helper'

describe 'samba::server::share' do
 context 'when running alone' do

    it { should have_resource_count(9) }
      let(:facts) {{ :osfamily => 'Debian', :lsbdistcodename => 'wheezy'}}
      let(:title) { 'browsable_share' }
      let(:params) { {:ensure => 'present', :browsable => true}}
      
#    it { should compile.with_all_deps }
    it { should contain_augeas('browsable_share-section') }
    it { should contain_augeas('browsable_share-changes').with_target(nil) }
    it { should contain_augeas('browsable_share-changes').with_incl(nil) }
    it { should contain_augeas('browsable_share-changes').with_lens(/Samba\.lns/) }
    it { should contain_augeas('browsable_share-changes').with_context(nil) }
    it { should contain_augeas('browsable_share-changes').with_changes(/browsable_share/) }
#   it { should have_samba__server__service_resource_count(1) }
#    it { should contain_class('samba::server::service') }
#    it { should contain_notify('Class[samba::server::service]') }
  end
end
