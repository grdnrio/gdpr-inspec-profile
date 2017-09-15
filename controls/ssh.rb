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

title 'SSH server config'

#only_if do
#  command('sshd').exist?
#end

control 'sshd-01' do
  impact 1.0
  title 'Server: Specify protocol version 2'
  desc "Only SSH protocol version 2 connections should be permitted. Version 1 of the protocol contains security vulnerabilities. Don't use legacy insecure SSHv1 connections anymore."
  describe sshd_config do
    its('Protocol') { should eq('2') }
  end
end

control 'sshd-02' do
  impact 1.0
  title 'Server: Enable StrictModes'
  desc 'Prevent the use of insecure home directory and key file permissions.'
  describe sshd_config do
    its('StrictModes') { should eq('yes') }
  end
end

control 'sshd-03' do
  impact 1.0
  title 'Server: Check for secure ssh ciphers'
  desc 'Configure a list of ciphers to the best secure ciphers (avoid older and weaker ciphers)'
  describe sshd_config do
    its('Ciphers') { should eq(ssh_crypto.valid_ciphers) }
  end
end

control 'sshd-04' do
  impact 1.0
  title 'Server: Specify the listen ssh Port'
  desc 'Always specify which port the SSH server should listen to. Prevent unexpected settings.'
  describe sshd_config do
    its('Port') { should eq('22') }
  end
end

control 'sshd-05' do
  impact 1.0
  title 'Server: Enable PubkeyAuthentication'
  desc 'Prefer public key authentication mechanisms, because other methods are weaker (e.g. passwords).'
  describe sshd_config do
    its('PubkeyAuthentication') { should eq('yes') }
  end
end
