# # encoding: utf-8

# Inspec test for recipe bioelite_php_fpm_56::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  describe command('php -v') do
    its('stdout') { should match(/5.6/) }
  end

  packages = %w[php5.6-cli php5.6-curl php5.6-mysql php5.6-sqlite3
                php5.6-fpm php5.6-xml php5.6-mbstring php5.6-zip
                php5.6-bcmath php5.6-mcrypt]

  packages.each do |php_pkg|
    describe package(php_pkg) do
      it { should be_installed }
    end
  end

  describe service('php5.6-fpm') do
    it { should be_running }
  end

  describe file('/run/php/php5.6-fpm.sock') do
    it { should exist }
    its('type') { should eq :socket }
    its('owner') { should eq 'www-data' }
  end

  describe file('/run/php/php5.6-fpm.pid') do
    it { should exist }
  end
end
