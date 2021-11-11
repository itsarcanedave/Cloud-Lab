provider "azurerm" {
	features{}
}

# create resource group
resource "azurerm_resource_group" "rg"{
    name = "cloud"
    location = "southeastasia"
}
resource "null_resource" "loadbalancer" {

        connection {
                type = "ssh"
                host = "[ALAMAT IP VM LOADBALANCER]"
                user = "azureuser"
                private_key  
= file("/home/[USERNAME]/[NAMA KEY PAIR.PEM]")
                }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install haproxy -y",
    ]
  }
}
resource "null_resource" "web1" {
        connection {
                type = "ssh"
                host = "20.212.117.95"
                user = "azureuser"
                private_key = file("/home/[NAMA-ANDA]/[NAMA-KEY].pem")
                }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
"sudo apt-get install apache2 ghostscript libapache2-mod-php mysql-server php php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip -y",
"sudo mkdir -p /srv/www",
"sudo chown www-data: /srv/www",
"curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www"
    ]
  }
}

resource "null_resource" "web2" {
        connection {
                type = "ssh"
                host = "20.212.117.64"
                user = "azureuser"
                private_key = file("/home/[NAMA-ANDA]/[NAMA-KEY].pem")
                }
provisioner "remote-exec" {
    inline = [
      "sudo add-apt-repository ppa:ondrej/php -y",
      "sudo apt-get update",
	"sudo apt-get install apache2 mysql-client mysql-server php7.4 libapache2-mod-php7.4 graphviz aspell ghostscript clamav php7.4-pspell php7.4-curl php7.4-gd php7.4-intl php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-ldap php7.4-zip php7.4-soap php7.4-mbstring -y",
"sudo service apache2 restart",
"sudo apt install git -y",
"cd /opt",
"sudo git clone git://git.moodle.org/moodle.git",
"cd moodle",
"sudo git branch -a",
"sudo git branch 
--track MOODLE_39_STABLE origin/MOODLE_39_STABLE",
	"sudo git checkout MOODLE_39_STABLE",
	"sudo cp -R /opt/moodle /var/www/html/",
	"sudo mkdir /var/moodledata",
	"sudo chown -R www-data /var/moodledata",
	"sudo chmod -R 777 /var/moodledata",
	"sudo chmod -R 0755 /var/www/html/moodle",
    ]
  }
}

