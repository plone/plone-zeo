# plone-zeo

A ZEO Server [Docker](https://docker.com) image using Python 3 and [pip](https://pip.pypa.io/en/stable/).

> **NOTE**: These images are not yet officially supported by the Plone Community.

## Supported tags and respective Dockerfile links

- `5.2.2, 5.2, latest` [(5.2/5.2.2/Dockerfile)](https://github.com/plone/plone-zeo/blob/main/5.2/5.2.2/Dockerfile)

## Using this image

### Simple usage

```shell
docker run -p 8100:8100 plone/plone-zeo:latest
```

### Docker-compose

Create a directory for your project, and inside it create a `docker-compose.yml` file that starts your Plone instance and the ZEO instance with volume mounts for data persistence:

```yaml
version: "3"
services:

  backend:
    image: plone/plone-backend:latest
    restart: always
    environment:
      USE_ZEO: 1    
    ports:
    - "8080:8080"
    depends_on:
      - zeo

  zeo:
    image: plone/plone-zeo:latest
    restart: always
    volumes:
      - data:/data
    ports:
    - "8100:8100"

volumes:
  data: {}
```

Now, run `docker-compose up -d` from your project directory.

Point your browser at http://localhost:8080 and you should see the default Plone site creation page.


### Persistent data

There are several ways to store data used by applications that run in Docker containers.

We encourage users of the `Plone` images to familiarize themselves with the options available.

[The Docker documentation](https://docs.docker.com/) is a good starting point for understanding the different storage options and variations.

## Configuration

The default image ships with a reasonable default configuration:

```
%define INSTANCE /app

<zeo>
  address 0.0.0.0:8100
  read-only false
  invalidation-queue-size 100
  pid-filename $INSTANCE/var/zeo.pid
</zeo>

<filestorage 1>
  path $INSTANCE/var/filestorage/Data.fs
  blob-dir $INSTANCE/var/blobstorage
  pack-keep-old false
</filestorage>

<eventlog>
  level info
  <logfile>
      path $INSTANCE/var/log/zeo.log
      format %(asctime)s %(message)s
    </logfile>
</eventlog>

<runner>
  program $INSTANCE/bin/runzeo
  socket-name $INSTANCE/var/zeo.zdsock
  daemon true
  forever false
  backoff-limit 10
  exit-codes 0, 2
  directory $INSTANCE
  default-to-interactive true

  # This logfile should match the one in the zeo.conf file.
  # It is used by zdctl's logtail command, zdrun/zdctl doesn't write it.
  logfile $INSTANCE/var/log/zeo.log
</runner>
```

In case you need to modify it, we suggest you to create a new image based on the default one:

```Dockerfile
FROM plone/plone-zeo:latest

COPY mylocalconfig /app/etc/zeo.conf
```
And then build the new image and start the container.


## Contribute

- [Issue Tracker](https://github.com/plone/plone-zeo/issues)
- [Source Code](https://github.com/plone/plone-zeo/)
- [Documentation](https://github.com/plone/plone-zeo/tree/main/docs)

Please **DO NOT** commit to main directly. Even for the smallest and most trivial fix.
**ALWAYS** open a pull request and ask somebody else to merge your code. **NEVER** merge it yourself.


## License

The project is licensed under the GPLv2.
