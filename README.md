# 2019 - WP GoDaddy -> Linode Transfer
## STEP ZERO
### Host Server

Download and install UpDraft from GitHub repo.

```
https://github.com/jeff-cald/wp-transfer-2019/raw/master/updraftplus.zip
```

Once installed, update all plugins and themes and issue BACKUP from UpDraft (Settings > Updraft). 

Once BACKUP has completed, download all the generated UpDraft BACKUP Files.

## STEP ONE
### Target Server
#### Preparation
On the new Linode server, you're going to have to install GIT to pull down the repository from GitHub. To do that, wait until WordPress finishes installing and run the following command to install GIT:

```bash
sudo apt-get install git
```

Once GIT has been installed, run the following command to download the GitHub repository in USER directory.

```bash
git clone https://github.com/jeff-cald/wp-transfer-2019.git
```

Once the project has been downloaded, change into project directory `cd wp-transfer-2019` and update the `site-name` variable in the `variables.sh` file with values of the site being transferred.

Update the values (from target WordPress site) of `<domain>` and `<support-email>` in the `/etc/apache2/sites-enabled/wordpress.conf` file; using the following command:

```bash
sudo nano /etc/apache2/sites-enabled/wordpress.conf
```

To finish Step ONE; run the following command:

```bash
bash one.sh
```

---    

#### Restore From Host Backup

Upload all files that were downloaded during Step ZERO from UpDraft.

Once all files have been uploaded, connect to Target Server through SSH, and run the following command:

```bash
wp updraftplus existing_backups --allow-root --path='/var/www/wordpress/'
```

Update the value of `UPDRAFT-SITE-ID` in the `variables.sh,` with the value for `nonce` from the output.

---
---
### CloudFlare or DNS Redirection

Once the above steps in Step ONE have been completed; it would be time to change over the DNS records of the domain to reflect the IP of the Linode server. If you want to change the domain to CloudFlare, now would be the time to set this up. 


## STEP TWO
### Target Server

```bash
bash two.sh
```
Upon completion, your site should be now working using the `http` protocol.

---
---
#### Setup CloudFlare

If you are using CloudFlare on this website, the plugin is already installed. Sign in and configure the account. Make sure `https` works on the `Flexible` SSL setting in your CloudFlare admin panel (on CloudFlare's website). Also, make sure that redirects to `https` are set on CloudFlare (both their website and the plugin).

Once you completed these setups, you need to generate an Origin CA to encrypt traffic from Origin to CloudFlare (`Flexible` only encrypts from CloudFlare to the end user). Go to CloudFlare's website, login, and go to Crypto. There scroll down to see `Origin CA,` there shouldn't be any certificates present. Generate a new certificate.

---

CloudFlare will display the certificate **ONE TIME** so it's essential to save them while you can.

###### `/etc/ssl/certs/ssl-cert-cloudflare.pem`

Run:
```bash
sudo nano /etc/ssl/certs/ssl-cert-cloudflare.pem
```

Now copy any paste `.pem` cert from CloudFlare Origin CA - Generated Certificate window.

###### `/etc/ssl/private/ssl-cert-cloudflare.key`

Run:
```bash
sudo nano /etc/ssl/private/ssl-cert-cloudflare.key
```

Now copy any paste `.key` cert from CloudFlare Origin CA - Generated Certificate window.

## STEP THREE
### Target Server
```bash
bash three.sh
```
Upon completion, run `apachectl restart` and your site should be now working using the `https` protocol and be fully deployed.

---
---
#### Setup CloudFlare
If you are using CloudFlare on this website, you should log into CloudFlare website (if you're not already logged in), go to Crypto, and change the setting to `FULL (Strict)` in the SSL area.