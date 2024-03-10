# UniFi Network Server

## Run with docker

```bash
docker run --rm -d -v "unifi_data:/usr/lib/unifi/data" -p "1900:1900/udp" -p "3478:3478/udp" -p "8080:8080" -p "8443:8443" -p "10001:10001/udp" --name "unifi-network-server" ghcr.io/maarlo/unifi-network-server:8.0.28
```

## Run with docker compose

```yaml
services:
  unifi-network-server:
    image: ghcr.io/maarlo/unifi-network-server:8.0.28
    restart: always
    volumes:
      - "unifi_data:/usr/lib/unifi/data"
    ports:
      - "53:53"            # optional
      - "53:53/udp"        # optional
      - "123:123/udp"      # optional
      - "1900:1900/udp"
      - "3478:3478/udp"
      - "5514:5514/udp"    # optional
      - "6789:6789"        # optional
      - "8080:8080"
      - "8443:8443"
      - "10001:10001/udp"

volumes:
  unifi_data:
```

## Hints

In order to change the IP address that adopted APs should use to communicate to the UniFi network server, follow the steps:

1. Execute the command below to open `system.properties` file:

    - Docker: `docker exec -it unifi-network-server nano /usr/lib/unifi/data/system.properties`
    - Docker compose: `docker compose exec -it unifi-network-server nano /usr/lib/unifi/data/system.properties`

2. Find the `system_ip=a.b.c.d` line
3. Modify `a.b.c.d` by your IP or FQDN
4. Exit with `Ctrl + X` + `y` + `Enter`
5. Restart the container