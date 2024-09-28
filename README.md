# Fail2Ban and Docker Microservices Example

Fail2Ban is one of the old school open-source intrusion prevention systems that is designed to provide additional layers of security for Unix based environments, It works by scanning log files for suspicious patterns or failed login attempts and then takes action by banning the IP address associated with the activity. Fail2Ban can be configured to monitor various services and protocols, including SSH, http/https, and FTP, among a host of others.  

This repository is a companion repository to the article on the [FlyingFlip.com](https://www.flyingflip.com/article/using-fail2ban-to-control-access-to-docker-applications) web site which talks about how to implement this on your own docker container.  

You can also view the sample Dockerfile on [DockerHub](https://hub.docker.com/r/flyingflip/fail2ban)
