def main(ctx):
  return [
    build("deluge", ["latest", "2.1.1"], { "DELUGE_VERSION": "2.1.1" }),
  ]

def build(name, tags=["latest"], args={}):
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
          "args": args,
          "context": name,
          "dockerfile": "%s/Containerfile" % name,
          "tags": tags,
         }
      }
    ]
  }
