#
# Cookbook:: sample
# Recipe:: tomcat
#
# Copyright:: 2021, The Authors, All Rights Reserved.

###installing tomcat###
package 'tomcat' do
  action :install
end

service 'tomcat' do
        action [:enable, :stop]
end

###Clearing tomcat webapps ROOT folder###
bash 'Clearing tomcat webapps ROOT folder' do
  user 'root'
  cwd '/home/vagrant'
  code <<-EOH
  sudo touch /var/lib/tomcat/webapps/ROOT
  sudo rm -rf /var/lib/tomcat/webapps/ROOT
  EOH
end

###copying and replacing existing ROOT.war with new ROOT.war in our cookbook files/default directory###
cookbook_file "/var/lib/tomcat/webapps/ROOT.war" do
  source "ROOT.war"
  mode "0644"
  notifies :restart, "service[httpd]"
  notifies :restart, "service[tomcat]"
end

#service 'tomcat' do
 #   action [:enable, :start]
#end
