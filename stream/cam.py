#!/usr/bin/python
# -*- coding: utf-8 -*-

import subprocess
import time
import psutil

while True:    # boucle infini
	
	
	f = open("/var/www/html/LiveStream/cam.txt", "r") # on ouvre le fichier cam.txt
	g = int(f.read())     # on le lit et met le resultat dans la variable g
	f.close()   # on ferme le fichier 
	

	if g == 1:	# si g = 1 donc.
		
		# on lance la prise de photos.		
		subprocess.call("sh /home/pi/stream/play.sh", shell=True)			
		# on remet 0 dans le fichier cam.txt
		subprocess.call("sudo cp /home/pi/stream/zero.txt /var/www/html/LiveStream/cam.txt", shell=True)
		
	if g == 2:	# si g = 2 donc.
		
		# on stop les programmes	
		subprocess.call("sh /home/pi/stream/stop.sh", shell=True)			
		# on remet 0 dans le fichier cam.txt
		subprocess.call("sudo cp /home/pi/stream/zero.txt /var/www/html/LiveStream/cam.txt", shell=True)
	
	time.sleep(2)	# attent 2s avant de reprendre la boucle



    


