# timezone設定
execute 'set timezone' do
    user "root"
    command <<-EOL
    cp -p /usr/share/zoneinfo/Japan /etc/localtime
    echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock
    echo 'UTC=false' >> /etc/sysconfig/clock
    EOL
end

# 言語設定
file '/etc/sysconfig/i18n' do
    action :edit
    user "root"
    block do |content|
        content.gsub!("en_US", "ja_JP")
    end
end

# vimのタブ幅、文字コード等設定
file '/home/vagrant/.vimrc' do
    action :create
    user "vagrant"
    content <<-EOL
    set tabstop=4
    set shiftwidth=4
    set noexpandtab
    set softtabstop=0
    set encoding=utf-8
    set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
    set fileformats=unix,mac,dos
    EOL
end

# firewalld停止、無効化
service 'firewalld' do
    action [:disable, :stop]
end

include_recipe "./cookbooks/apache/default.rb"
include_recipe "./cookbooks/php/default.rb"
include_recipe "./cookbooks/mysql/default.rb"
include_recipe "./cookbooks/phpmyadmin/default.rb"

# Apache起動、有効化
service 'httpd' do
    action [:start, :enable]
end
