# purpose: install docker,docker-compose and jenkins on Amazon Linux2 OS.

# install docker
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

# make docker auto-start
sudo chkconfig docker on

# install git
sudo yum install -y git

# install docker-compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

# fix permission
sudo chmod +x /usr/local/bin/docker-compose

# create link
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# run jenkins
mkdir -p /var/jenkins_home
chown -R 1000:1000 /var/jenkins_home/
docker run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home -d --name jenkins jenkins/jenkins:lts

# show endpoint
echo 'Jenkins is up and can be accessed at: http://'$(curl -s ifconfig.co)':8080'
