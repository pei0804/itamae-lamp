# phpMyAdminインストール
package 'phpMyAdmin'

# phpMyAdmin権限設定
execute 'phpMyAdmin permission' do
    command <<-EOL
    chown -R root:apache /usr/share/phpMyAdmin/
    EOL
end

# phpMyAdmin.confのバックアップ
execute 'phpMyAdmin.conf backup' do
    command 'cp /etc/httpd/conf.d/phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf.org'
end

# phpMyAdmin.confの設定
file '/etc/httpd/conf.d/phpMyAdmin.conf' do
    action :edit
    block do |content|
        content.gsub!("Allow from ::1", "Allow from ::1\n     Allow from 192.168.")
    end
end