# Основной репозиторий (установочный диск)
deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository smolensk main contrib non-free
 
## Актуальное оперативное обновление основного репозитория
deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository-update/ smolensk main contrib non-free
```markdown
# 
sudo cp astra/keys/astra_echelon_pub_key.gpg /etc/digsig/keys/
##
sudo nano /etc/digsig/digsig_initramfs.conf
DIGSIG_ELF_MODE=1
sudo update-initramfs -u -k all
sudo reboot
##
sudo su
apt install postgresql ca-certificates -y
cd /astra/db/clickhouse/
dpkg -i ./*.deb
`пароль для пользователя default`
service clickhouse-server start
echo "pass"; echo -n "pass" | sha256sum | tr -d '-'
sudo nano /etc/clickhouse-server/users.d/komrad.xml

<yandex>
	<users>
		<komrad>
			<password remove='1' />
			<password_sha256_hex>pass_SHA256</password_sha256_hex>
		</komrad>
	</users>
</yandex>

sudo nano /etc/clickhouse-server/users.xml

<!-- Users and ACL. -->
<users>
	<komrad>
		<access_management>1</access_management>
		<password></password>
	</komrad>
<!-- If user name was not specified, 'default' user is used. -->
<default>

sudo systemctl restart clickhouse-server.service
```
<details>
  <summary>Screen recording</summary>

  ![](https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/configuration-wizard.gif)
</details>
