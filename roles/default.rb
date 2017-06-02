include_recipe "../cookbooks/vim/default.rb"

service "httpd" do
  action [:enable, :start, :restart]
end
