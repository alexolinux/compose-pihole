# compose-pihole

---------------------

## Orchestrated Network Tool for **[Raspberry PI](https://www.raspberrypi.com/tutorials/)**

This project provides docker-compose files to deploy a network-wide ad blocker (Pi-hole) and a recursive DNS resolver (Unbound) on your system. It is designed to run on a Raspberry Pi or any other system capable of running Docker. In addition, it also includes a reverse proxy (nginx-proxy-manager) and a dynamic DNS client (duckdns).

### Main Services

- **Pi-hole**: Network-wide Ad blocker
- **Unbound**: Recursive DNS resolver
- **Nebula-Sync**: Pi-hole instances syncronizer.

### Extra Services

- **Nginx Proxy Manager**: Reverse proxy
- **DuckDNS**: Dynamic DNS client

## What is Pi-hole?

[Pi-hole](https://pi-hole.net/) is a network-wide ad blocker that acts as a DNS sinkhole, blocking ads and trackers at the DNS level. It provides a web interface for monitoring and managing DNS queries.

### Features

- **Ad Blocking**: Blocks ads and trackers across all devices on your network.
- **Recursive DNS**: Resolves DNS queries directly for improved privacy.
- **Customizable**: Easily configure ports, subdomains, and other settings.
- **Persistence**: Stores configuration and data in local volumes for durability.

## What is Unbound?

[Unbound](https://unbound.docs.nlnetlabs.nl/en/latest/) is a validating, recursive, and caching DNS resolver. It enhances privacy and security by resolving DNS queries directly without relying on third-party DNS providers.

## What is Nebula Sync?

[Nebula Sync](https://github.com/lovelaze/nebula-sync) is a tool that synchronizes DNS blocklists between multiple Pi-hole instances. In this project, it is used to synchronize DNS blocklists between the primary and secondary Pi-hole instances.

## What is Nginx Proxy Manager?

[Nginx Proxy Manager](https://github.com/NginxProxyManager/nginx-proxy-manager) is a reverse proxy that allows you to easily manage SSL certificates and forward traffic to your applications.

## What is DuckDNS?

[DuckDNS](https://www.duckdns.org/) is a free dynamic DNS service that allows you to use a custom domain name for your home IP address.

## Requirements

- [**Docker**](https://docs.docker.com/get-docker/) and [**Docker Compose**](https://docs.docker.com/compose/install/) installed on your system.
- A `.env` file with the required environment variables (see below).
- Basic knowledge of Docker and networking.

## Environment Variables

Check/Use the template file `env_template` and creating your own `.env` file.

## How to use

1. Copy the `env_template` file to `.env`
2. Edit the `.env` file with your desired values
3. Run `docker-compose up -d` to start the services

## Author

Alex Mendes

https://www.alexolinux.com
