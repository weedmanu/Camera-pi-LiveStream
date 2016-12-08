<?php 
	
  // Si le tableau $_POST existe alors le formulaire a été envoyé
  if(!empty($_POST))
  {
	  
	    $lecteur = $_POST['lecteur']; 	
	    
	    $monfichier = fopen('/var/www/html/LiveStream/cam.txt', 'r+');
		$cam = fgets($monfichier); // On lit la première ligne 	    
	    
		if ($lecteur == 'play') {	

			$rep = 1; // On met 1
			fseek($monfichier, 0); // On remet le curseur au début du fichier
			fputs($monfichier, $rep); // On écrit le nouveau nombre 			
			$affiche = '<iframe id="cam" src="http://192.168.0.75:8080/cam.html" /></iframe>';
				
						
			} else  { 	
				
				$rep = 2; // On met 2
				fseek($monfichier, 0); // On remet le curseur au début du fichier
				fputs($monfichier, $rep); // On écrit le nouveau nombre 							
				$affiche = "";	
				 										
				}			
}
?>

<!DOCTYPE html> 
<head> 
	<meta charset="utf-8" /> 
	<title>Streamming</title> <!-- titre -->
	<link rel="icon" type="image/png" href="cam.png" />
    <script type="text/javascript" src="dateheure.js"></script> <!-- appel de la fonction date et heure javascript --> 
    <link rel="stylesheet" href="index.css" /> <!-- appel du thème de la page -->   
</head>   
<body>

 <header> 		
	
	<div class="element" id="date">
		<span id="date"></span>
		<script type="text/javascript">window.onload = date('date');</script>
	</div>  
	
	<div class="element" id="heure">
		<span id="heure"></span>
		<script type="text/javascript">window.onload = heure('heure');</script>
	</div>	
		
 </header>
 
<div id="content">
	
    <main><div id="cam" class="element"><?php echo $affiche;?></div></main>
    
    
    <nav>
			<div class="element">
			<fieldset>
				<legend>Live streaming</legend>
				<form method="post" action="index.php">  			 
				   <select name="lecteur" id="lecteur">
					   <option value="play" selected>play</option>
					   <option value="stop">stop</option>
				   </select> 							
					<input type="submit" name="submit" id="submit" value="valider" />				
				</form>	
			</fieldset>
			</div>
			
			 
    </nav>
    
    
    
</div>

 
 </body>

</html>
