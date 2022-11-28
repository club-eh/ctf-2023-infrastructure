kubectl create secret generic -n "auth" "oauth2-proxy-client" --from-file="client-id=../secrets/api_token_github_oauth2_id" --from-file="client-secret=../secrets/api_token_github_oauth2_secret"
