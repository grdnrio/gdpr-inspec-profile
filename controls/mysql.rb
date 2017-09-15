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

title 'MySQL configuration'

control 'my-01' do
  impact 1.0
  title 'Check MYSQL is running'
  desc 'Make sure the service is running and enabled'
  describe service(mysql) do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'my-02' do
  impact 1.0
  title 'Check multiple instances'
  desc 'Ensure there is only a single MySQL instance running on the server'
  describe command('ps aux | grep mysqld | egrep -v "grep|mysqld_safe|logger" | wc -l') do
    its(:stdout) { should match(/^1$/) }
  end
end

control 'my-03' do
  impact 1.0
  title 'Check config file permissions'
  desc 'Ensure permissions are correct on the mysql config file'
  describe file('/etc/mysql/my.cnf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should_not be_readable.by('others') }
  end
end

control 'my-04' do
  impact 1.0
  title 'Chef my.cnf options'
  desc 'Ensure my.cnf has secure configuration options'
  describe mysql_conf('/etc/mysql/my.cnf') do
    its('bind-address') { should eq '127.0.0.1' }
    its('skip-show-database') { should exist }
    its('port') { should_not eq '3306' }
  end
end
