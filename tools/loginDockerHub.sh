echo "this is a easy helper script to log into docker HUB"
echo "INFO the passwort will be casted into a txt file, which gets deleted in the end"
echo "this prevents the pw to be visible in the log"

read -p "user name: " user
read -p "pw: " -s pw
echo " "
echo $pw > pw.txt
cat pw.txt | docker login --username $user --password-stdin

echo "temp pw file will be removed"
rm pw.txt
