# The Lib42 Rootless Containers Library [![status-badge](https://ci.nold.in/api/badges/lib42/rootless-containers/status.svg)](https://ci.nold.in/lib42/rootless-containers)

Many public container images run as root, even though most applications don't need to be / should not run as root. We want to change this, one container image at a time!

## Why use Lib42 Rootless Images?

* Our images are build with security & best practices in mind
* All images are freshly built every week & scanned for security issues
* For many applications there are matching Helm-Charts available in our [Chart Repository](https://github.com/lib42/charts)

## Principles

All images...
* contain an unprivileged application user [UID > 0]
* may prefer maintainability over image size [e.g. using package managers over self-compiling applications]
* are as minimal as possible [e.g. one process per container]
* are designed with Kubernetes/Cloud Native use-cases in mind [e.g. ConfigMaps, init containers, etc.]

NOTE: As this is a jung project, there principles might change over time. Contributions welcome!

## Get an image

The recommended way to get any of the Lib42 Images is to pull the prebuilt image from the [Docker Hub Registry](https://hub.docker.com/r/lib42/).

```console
$ docker pull lib42/APP
```

To use a specific version, you can pull a versioned tag.

```console
$ docker pull lib42/APP:[TAG]
```

If you wish, you can also build the image yourself by cloning the repository, changing to the directory containing the `Containerfile` and executing the `docker/podman/buildah/... build` command.

```console
$ git clone https://github.com/lib42/rootless-containers
$ cd rootless-containers/APP
$ docker build -f Containerfile -t lib42/APP .
```

> Remember to replace the `APP` placeholder in the example command above with the correct value.

## Vulnerability scan in Lib42 container images

As part of the release process, the Lib42 container images are analyzed for vulnerabilities. At this moment, we are using:

* [Trivy](https://github.com/aquasecurity/trivy)

This scanning process is triggered via a CI for every build image.

## Contributing

We'd love for you to contribute to those container images. You can request new features by creating an issue, or submit a pull request with your contribution.

## License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
