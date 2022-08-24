# plone-zeo

A ZEO Server [Docker](https://docker.com) image using Python 3 and [pip](https://pip.pypa.io/en/stable/).

> **NOTE**: These images are not yet officially supported by the Plone Community.

## Supported tags and respective Dockerfile links

### Latest

- `5, 5.3, 5.3.0,latest` [(5.3.0/Dockerfile)](https://github.com/plone/plone-zeo/blob/v5.3.0/Dockerfile)

### Nightly build

- `nightly` [(Dockerfile.nightly)](https://github.com/plone/plone-zeo/blob/main/Dockerfile.nightly)


### Previous

- `5.2, 5.2.2, 5.2.2--python39` [(5.2.2/Dockerfile)](https://github.com/plone/plone-zeo/blob/v5.2.2/5.2/5.2.2/Dockerfile.python39)

## Usage

Please refer to the [Official Plone Documentation](https://6.dev-docs.plone.org/install/containers/images/zeo.html) for further documentation and examples.


### Persistent data

There are several ways to store data used by applications that run in Docker containers.

We encourage users of the `Plone` images to familiarize themselves with the options available.

[The Docker documentation](https://docs.docker.com/) is a good starting point for understanding the different storage options and variations.

## Configuration

### Main variables

| Environment variable                      | ZEO  option                    | Default value                   |
| ----------------------------------------- | ------------------------------ | ------------------------------- |
| ZEO_PORT                                  | address                        | 8100                            |
| ZEO_READ_ONLY                             | read-only                      | false                           |
| ZEO_INVALIDATION_QUEUE_SIZE               | invalidation-queue-size        | 100                             |
| ZEO_PACK_KEEP_OLD                         | pack-keep-old                  | true                            |


In case you need to configure an option not present in the environment variables, we suggest you to create a new image based on the default one:

```Dockerfile
FROM plone/plone-zeo:latest

COPY mylocalconfig /app/etc/zeo.conf
```
And then build the new image and start the container.


## Contribute

- [Issue Tracker](https://github.com/plone/plone-zeo/issues)
- [Source Code](https://github.com/plone/plone-zeo/)
- [Documentation](https://6.dev-docs.plone.org/install/containers/images/zeo.html)

Please **DO NOT** commit to main directly. Even for the smallest and most trivial fix.
**ALWAYS** open a pull request and ask somebody else to merge your code. **NEVER** merge it yourself.

## Credits

This project is supported by:

[![Plone Foundation](https://raw.githubusercontent.com/plone/.github/main/plone-foundation.png)](https://plone.org/)

## License

The project is licensed under the GPLv2.
