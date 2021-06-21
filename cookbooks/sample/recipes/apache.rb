#
# Cookbook:: sample
# Recipe:: apache
#
# Copyright:: 2021, The Authors, All Rights Reserved.

package 'httpd' do
  action :install
end

#file '/var/www/html/index.html' do
 #   content '<h1>Hello, world!</h1>'
#end

file '/etc/httpd/conf.d/bhansali.in.conf' do
  content '<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName localhost
    DocumentRoot /var/www/html
    ProxyPreserveHost on
    ProxyRequests off
    ProxyPass /phpmyadmin !
    ProxyPass / http://localhost:8080/
    ProxyPassReverse / http://localhost:8080/
    </VirtualHost>'
end

template '/etc/hosts' do
    source 'hosts.erb'
end

service 'httpd' do
      action [:stop, :start, :enable]
end
