REPO_OWNER="{%%REPO_OWNER%%}"
REPO_NAME="{%%REPO_NAME%%}"
GITHUB_USER="{%%GITHUB_USER%%}"

# Who we are for git
git config --global user.email "{%%COMMIT_EMAIL%%}"
git config --global user.name "{%%COMMIT_NAME%%}"
git config --global push.default simple
