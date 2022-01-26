curl -v \
-H 'X-GitHub-Event: pull_request' \
-H 'X-Hub-Signature: sha1=11e4f57e845a7b5add651b2ae9a59eae5d8864b6' \
-H 'Content-Type: application/json' \
--data-binary "@github-push-event.json" \
http://localhost:8081
