#!/bin/sh
echo "What is the name of the application you wish to log? (ex. cura-lulzbot, evolution, etc.)"
read varApp
echo "Great, let's figure out where to stash the logs for "$varApp
echo "Use default file path? ["$HOME"/logs/"$varApp"] (y/n)"
read yn
if [ "$yn" = "y" ]; then
	varFilepath=${filepath:-$HOME/logs/$varApp}	
else
	read -p "Enter file path: " varFilepath
fi

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
