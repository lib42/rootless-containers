registry = "docker.io/lib42"
images = [
    {
      "name": "deluge",
      "tags": [ "latest", "2.1.1" ],
      "args": [ ],
    },
  ]


def main(ctx):
  steps = []

  for image in images:
    steps.append(
      {
        "name": "build-%s" % image["name"],
        "image": "plugins/kaniko",
        "settings": {
          "username": {
              "from_secret": "docker_username"
            },
          "password": {
              "from_secret": "docker_password"
            },
          "repo": "%s/%s" % (registry, image["name"]),
          "build_args": image["args"],
          "context": image["name"],
          "dockerfile": "%s/Containerfile" % image["name"],
          "tags": image["tags"],
         }
      }
    )

    # Security Scan
    steps.append(
    {
        "name": "security-scan",
        "image": "aquasec/trivy:latest",
        "commands": [
          "trivy image -o /cache/trivy-%s.html --format template --template '@contrib/html.tpl' \
          --no-progress --list-all-pkgs %s/%s:%s" \
          % (image["name"], registry, image["name"], image["tags"][0])
        ],
        "depends_on": [ "build-%s" % image["name"]],
        "volumes": [
          {
            "name": "cache",
            "path": "/cache"
          }
        ]
      }
    )

  return {
    "kind": "pipeline",
    "type": "kubernetes",
    "name": "build-%s" % image["name"],
    "steps": steps,
    "volumes": [
      {
        "name": "cache",
        "temp": {}
      }
    ]
  }
