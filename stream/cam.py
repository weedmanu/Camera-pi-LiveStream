#!/usr/bin/python
# -*- coding: utf-8 -*-

import subprocess
import shlex
import time
import psutil

while True:    # boucle infini
	
	
	f = open("/var/www/html/terraspi/stream/cam.txt", "r") # on ouvre le fichier code.txt
	g = int(f.read())     # on le lit et le met dans la variable g
	f.close()   # on ferme le fichier 
	

	if g == 1:	# si g = 1 donc.
		
		# on lance la prise de photos.		
		subprocess.call("/var/www/html/terraspi/stream/./play.sh", shell=True)			
		# on remet 0 dans le fichier code.txt
		subprocess.call("sudo cp /var/www/html/terraspi/stream/zero.txt /var/www/html/terraspi/stream/cam.txt", shell=True)
		
	if g == 2:	# si g = 2 donc.
		
		# on stop les programmes	
		subprocess.call("/var/www/html/terraspi/stream/./stop.sh", shell=True)			
		# on remet 0 dans le fichier code.txt
		subprocess.call("sudo cp /var/www/html/terraspi/stream/zero.txt /var/www/html/terraspi/stream/cam.txt", shell=True)
	
	time.sleep(2)	# attent 2s avant de reprendre la boucle



    

