# encoding: utf-8
#
# Copyright 2017, Joe Gardiner
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

title 'OS base config'

control 'os-01' do
  impact 1.0
  title 'Check owner and permissions for /etc/passwd'
  desc 'Check periodically the owner and permissions for /etc/passwd'
  describe file('/etc/passwd') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    its('group') { should eq 'root' }
    it { should_not be_executable }
    it { should be_writable.by('owner') }
    it { should_not be_writable.by('group') }
    it { should_not be_writable.by('other') }
    it { should be_readable.by('owner') }
    it { should be_readable.by('group') }
    it { should be_readable.by('other') }
  end
end

control 'os-02' do
  impact 1.0
  title 'Check default mount is encrypted'
  desc 'Check filesystem encryption at default mount point'
  describe mount('/') do
    it { should be_mounted }
    its('type') { should include 'crypt' }
  end
end

control 'os-03' do
  impact 1.0
  title 'Do not install Telnet server'
  desc 'Telnet protocol uses unencrypted communication, that means the password and other sensitive data are unencrypted.'
  describe package('telnetd') do
    it { should_not be_installed }
  end
end

control 'os-04' do
  impact 1.0
  title 'Do not install tftp server'
  desc 'tftp-server provides little security'
  describe package('tftp-server') do
    it { should_not be_installed }
  end
end

control 'os-05' do
  impact 1.0
  title 'Check root password length'
  desc 'The root password should not be less than 16 characters'
  describe passwd.users('root') do
    its('length') { should_not be < 16 }
  end
end
