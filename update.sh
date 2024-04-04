#!/bin/bash
# Template conversion tool
# Converts between Gitpod and CodeAnywhere templates
# Niel McEwen & Matt Rudge, 2024

cafolder=".devcontainer"
gitpodfolder=".vscode"
ide="Gitpod"

if [ -d "$cafolder" ] ; then
    echo "Converting from CodeAnywhere to Gitpod"
    rm -rf "$cafolder"
    wget https://raw.githubusercontent.com/Code-Institute-Org/gitpod-full-template/main/.gitpod.dockerfile && curl https://raw.githubusercontent.com/Code-Institute-Org/gitpod-full-template/main/.gitpod.yml > .gitpod.yml
    mkdir .vscode && cd .vscode && wget https://raw.githubusercontent.com/Code-Institute-Org/gitpod-full-template/main/.vscode/uptime.sh && wget https://raw.githubusercontent.com/Code-Institute-Org/gitpod-full-template/main/.vscode/init_tasks.sh && wget https://raw.githubusercontent.com/Code-Institute-Org/gitpod-full-template/main/.vscode/heroku_config.sh && wget https://raw.githubusercontent.com/Code-Institute-Org/gitpod-full-template/main/.vscode/make_url.py && wget https://raw.githubusercontent.com/Code-Institute-Org/gitpod-full-template/main/.vscode/arctictern.py && cd ..
elif [ -d "$gitpodfolder" ] ; then
    echo "Converting from Gitpod to CodeAnywhere"
    ide="CodeAnywhere"
    rm -rf "$gitpodfolder"
    rm .gitpod.yml && rm .gitpod.dockerfile && mkdir .devcontainer && cd .devcontainer && wget https://raw.githubusercontent.com/Code-Institute-Org/ci-full-template/main/.devcontainer/Dockerfile && wget https://raw.githubusercontent.com/Code-Institute-Org/ci-full-template/main/.devcontainer/devcontainer.json && wget https://raw.githubusercontent.com/Code-Institute-Org/ci-full-template/main/.devcontainer/docker-compose.yml && mkdir build-assets && cd build-assets && wget https://raw.githubusercontent.com/Code-Institute-Org/ci-full-template/main/.devcontainer/heroku_config.sh && wget https://raw.githubusercontent.com/Code-Institute-Org/ci-full-template/main/.devcontainer/http_server.py && wget https://raw.githubusercontent.com/Code-Institute-Org/ci-full-template/main/.devcontainer/make_url.py && cd .. && cd ..
fi

clear
echo "Conversion complete. You will now be asked whether you want the script"
echo "to automatically add, commit and push the changes to GitHub. After this"
echo "has been done, close this workspace and recreate it from GitHub."
echo ""
echo -n "Would you like me to add, commit and push to GitHub for you? [yes / no]: "
read answer
echo ""

if [ $answer = "yes" ] || [ $answer = "y" ] || [ $answer = "YES" ] || [ $answer = "Y" ] ; then
    git add .
    git commit -m "Updated workspace to use $ide"
    git push
    echo "All done! Please close this workspace and recreate it."
else
    echo "You will need to add, commit and push to GitHub manually"
    echo "before recreating this workspace"
fi