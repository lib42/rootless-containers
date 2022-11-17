images = [
    {
      "name": "deluge",
      "tags": [ "latest", "2.1.1" ],
      "args": [ "DELUGE_VERSION=" ],
    },
  ]


def main(ctx):
  builds = []
  for image in images:
    builds.append(build(image["name"], image["tags"], image["args"]))
  return builds

def build(name, tags=["latest"], args=[]):
  return {
    "kind": "pipeline",
    "type": "kubernetes",
    "name": "build-%s" % name,
    "steps": [
      {
        "name": "build",
        "image": "plugins/kaniko",
        "settings": {
          "username": {
              "from_secret": "docker_username"
            },
          "password": {
              "from_secret": "docker_password"
            },
          "repo": "lib42/%s" % name,
          "build_args": args,
          "context": name,
          "dockerfile": "%s/Containerfile" % name,
          "tags": tags,
         }
      },
      {
        "name": "security-scan",
        "image": "aquasec/trivy:latest",
        "commands": [
          "trivy image --no-progress --list-all-pkgs %s:%s" % (name, tags[0])
        ]
        }
    ]
  }
