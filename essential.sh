echo
echo "------------------"
echo " Installer Script "
echo " by MrFluffyOven  " 
echo "  Essential Only  " 
echo "------------------"
echo


Snap&Curl() {
echo "--> Installing Snap & Curl" 
sudo apt-get install snap
snap install curl
echo 
}  


Git&Repo() {
echo "--> Installing Git & Repo" 
sudo apt-get install git-all  
sudo apt-get install repo
sudo apt-get install git-lfs
echo
} 


Python() {
echo "--> Installing Python 3.11" 
sudo apt-get install python3.11
sudo apt-get install python-is-python3 
sudo apt-get install python3-pip
pip3 install lunch
echo 
}


Gradle() {
echo "--> Installing JDK 11"
sudo apt-get install openjdk-11-jdk
echo

echo "--> Installing Gradle 7.2"
snap install gradle --classic
echo 
} 


START=$(date +%s)

Snap&Curl
Git&Repo
Python
Gradle

END=$(date +%s)
ELAPSEDM=$(($(($END-$START))/60))
ELAPSEDS=$(($(($END-$START))-$ELAPSEDM*60))

echo "--> Install Script completed in $ELAPSEDM minutes and $ELAPSEDS seconds"
echo