def main(ctx):
  return [
    build("deluge", "latest"),
  ]

def build(name, tag):
  return {
    "kind": "pipeline",
    "type": "kubernetes",
    "name": "build-%s" % name,
    "steps": [
      {
        "name": "build",
        "image": "plugins/kaniko",
        "username": {
            "from_secret": "docker_username"
          },
        "password": {
            "from_secret": "docker_password"
          },
        "repo": "lib42/%s" % name,
        "context": name,
        "tags": [ tag ]
      }
    ]
  }
