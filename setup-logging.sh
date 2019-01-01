#!/bin/sh
echo "What is the name of the application you wish to log? (ex. cura-lulzbot, evolution, etc.)"
read varApp
echo "Great, where shall we stash the logs for "$varApp"?"
read -p "Enter file path ["$HOME"/logs/"$varApp"]:" varFilepath
varFilepath=${filepath:-$HOME/logs/$varApp}
echo "Coolio, I'll stash the logs in "$varFilepath"."
if [ ! -d $varFilepath ]; then
	echo $varFilepath" not found, so I'll create it."
	mkdir -p $varFilepath
else
	echo $varFilepath" exists, so I'll use that."
fi

if [ ! -d $HOME/bin ]; then
	echo $HOME/bin" not found, so I'll create it and put the executable there."
	mkdir -p $HOME/bin
else
	echo $HOME"/bin exists, so I'll put the executable there."
fi
cd $HOME/bin
printf "#!/bin/sh \nscript $varFilepath/\`date +\"%%Y%%m%%d%%H%%M%%S\"\`.log -f -c $varApp" > log-$varApp.sh
chmod a+rx log-$varApp.sh
