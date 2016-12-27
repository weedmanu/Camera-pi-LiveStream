#!/bin/bash

MAJ=(
'apt-get update' 
'apt-get upgrade'
)
whiptail --title "Vérification et installation des mises à jour" --gauge "Veuillez patienter pendant la mise à jour" 10 75 0 < <(
   n=${#MAJ[*]}; 
   i=0
   for f in "${MAJ[@]}"
   do
	  $f -y >>instal.log 2>&1
      avancement=$(( 100*(++i)/n ))
      echo "${avancement}%" >>instal.log
            
cat <<EOF
XXX
$avancement
Commande en cours : "$f"...
XXX
EOF
  
   done
)

PROG=(
'apt-get install apt-transport-https' 
'apt-get install subversion' 
'apt-get install libjpeg8-dev'
'apt-get install imagemagick' 
'apt-get install libv4l-dev' 
'apt-get install python-dev' 
'apt-get install python-openssl' 
'apt-get install python-pip' 
'apt-get install git' 
'apt-get install apache2' 
'apt-get install php5' 
'apt-get install libapache2-mod-php5' 
'apt-get install php5-mysql'
)
whiptail --gauge "Installation des programmes, veuillez patienter..." 10 75 0 < <(
   n=${#PROG[*]}; 
   i=0
   for f in "${PROG[@]}"
   do
	  $f -y >>instal.log 2>&1
      avancement=$(( 100*(++i)/n ))
      echo "${avancement}%" >>instal.log
      
cat <<EOF
XXX
$avancement
Commande en cours : "$f"...
XXX
EOF
   
   done
)

LIB=(
'pip install psutil'
)
whiptail --title "Installation des librairies python" --gauge "Installation des librairies python, veuillez patienter..." 10 75 0 < <(
   n=${#LIB[*]}; 
   i=0
   for f in "${LIB[@]}"
   do
	  $f >>instal.log 2>&1
      avancement=$(( 100*(++i)/n ))
      echo "${avancement}%" >>instal.log
      
cat <<EOF
XXX
$avancement
Commande en cours : "$f"...
XXX
EOF
  
   done
)

ln -s /usr/include/linux/videodev2.h /usr/include/linux/videodev.h
svn co https://svn.code.sf.net/p/mjpg-streamer/code/ >>instal.log 2>&1
cd code/mjpg-streamer
make mjpg_streamer input_file.so output_http.so >>instal.log 2>&1
cp mjpg_streamer /usr/local/bin
cp output_http.so input_file.so /usr/local/lib/
cp -R www /usr/local/www
rm -r /home/pi/code
cp /usr/local/www/stream_simple.html /usr/local/www/cam.html
cd /var/www/html/
rm index.html
chown www-data:pi /var/www/html/
chmod 770 /var/www/html/
cd /home/pi

URL=(https://github.com/weedmanu/Camera-pi-LiveStream.git)
whiptail --title "pages web et scripts" --gauge "Téléchargement de la page web et des scripts, veuillez patienter..." 10 75 0 < <(
   n=${#URL[*]}; 
   i=0
   for f in "${URL[@]}"
   do
      git clone $f  >>instal.log 2>&1
      avancement=$(( 100*(++i)/n ))
      echo "${avancement}%" >>instal.log
      
cat <<EOF
XXX
$avancement
Commande en cours : "$f"...
XXX
EOF
  
   done
)

mv Camera-pi-LiveStream/stream -t /home/pi/
mv /home/pi/stream/LiveStream -t /var/www/html/
rm -r /home/pi/Camera-pi-LiveStream
cp /etc/rc.local /home/pi/test
sed -i '$d' test
echo "python /home/pi/stream/cam.py &" >> test
echo "" >> test
echo "exit 0" >> test
mv test /etc/rc.local
chown -R www-data:pi /var/www/html/
chmod -R 770 /var/www/html/
python /home/pi/stream/cam.py &
CONNECTION=$(whiptail --title "Connexion" --radiolist \
"Quelle connection utilisez vous ?" 15 75 4 \
"wlan0" "le Wifi" ON \
"eth0" "l'ethernet" OFF 3>&1 1>&2 2>&3) 
exitstatus=$?
if [ $exitstatus = 0 ]; then
    monip=`ifconfig $CONNECTION | grep "inet adr" | sed 's/.*adr:\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\).*/\1/'`
    whiptail --title "FIN" --msgbox "Ouvrez ce lien: http://${monip}/LiveStream/  pour voir le résultat \net cliquez OK pour fermer le programme d installation." 10 75
else
    echo "Vous avez annulé, pour voir la page web : http://adresse_ip_du_pi/LiveStream/"
fi
chown -R pi /home/pi/stream
chmod -R 770 /home/pi/stream
rm install.sh
exit

