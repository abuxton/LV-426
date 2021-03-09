#! /bin/bash -x
# simple upgrade to minecraft using symlink binary approach
# at some point i'll variabelise the version and the download url for curl

MC_VERSION
# url from https://www.minecraft.net/en-us/download/server
MC_DOWNLOAD_URL=${curl -sN https://www.minecraft.net/en-us/download/server | grep server.jar | sed -e 's/<a /<a /g'  | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d' | tr -d "[:blank:]"}
# curl -O https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar /opt/minecraft/vanilla/minecraft_server.${MC_VERSION}.jar
curl -O  ${MC_DOWNLOAD_URL} /opt/minecraft/vanilla/minecraft_server.${MC_VERSION}.jar
curl -sN https://www.minecraft.net/en-us/download/server | grep server.jar | sed -e 's/<a /<a /g'  | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d' | tr -d "[:blank:]"
chown minecraft:minecraft minecraft_server.${MC_VERSION}.jar
systemctl stop minecraft@vanilla.service
ln -fs /opt/minecraft/vanilla/minecraft_server.${MC_VERSION}.jar minecraft_server.jar
systemctl start minecraft@vanilla.service
systemctl status minecraft@vanilla.service
