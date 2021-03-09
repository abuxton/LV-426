#! /bin/bash -x
# simple upgrade to minecraft using symlink binary approach
# at some point i'll variabelise the version and the download url for curl

MC_VERSION
# url from https://www.minecraft.net/en-us/download/server
# grok the url from teh server download page
MC_DOWNLOAD_URL=${curl -sN https://www.minecraft.net/en-us/download/server | grep server.jar | sed -e 's/<a /<a /g'  | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d' | tr -d "[:blank:]"}
# now grab the server.jar
# curl -O https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar /opt/minecraft/vanilla/minecraft_server.${MC_VERSION}.jar
curl -O  ${MC_DOWNLOAD_URL} /opt/minecraft/vanilla/minecraft_server.${MC_VERSION}.jar
# chown the new jar to minecraft user
chown minecraft:minecraft /opt/minecraft/vanilla/minecraft_server.${MC_VERSION}.jar
# stop the service
systemctl stop minecraft@vanilla.service
# force chnage of symlink
ln -fs /opt/minecraft/vanilla/minecraft_server.${MC_VERSION}.jar minecraft_server.jar
# restart the service
systemctl start minecraft@vanilla.service
# check the status
systemctl status minecraft@vanilla.service

# House keeping task remove the old .jar they are going into the back up and the largest single object.
# Careful not to remove the live server jar, and check it's all running first.
