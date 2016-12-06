<!DOCTYPE html>
<html>

<body>

<h2 align="center">License Usage over the past year</h2>

<!--Runs the R script to produce plot if it hasn't already done so in the last hour and get the date and time of most recent update-->
<?php
    $Rfile = '/[dataPath]/licensePlots.R';
    $plotfile = '/[dataPath]/lic-usage-plot.png';
    $lastUpdated = date ("F d Y H:i:s.", filemtime($plotfile));
    //if (time() >= strtotime($lastUpdated)+60*60) {
    exec("/usr/bin/Rscript $Rfile ; sleep 0.1");
    $lastUpdated = date ("F d Y H:i:s.", filemtime($plotfile)); 
    //}      
?>

<!--Shows plot and time last updated-->
<center>
    <div>
        <img align="" src="/~lmguru/lic-usage-plot.png" alt="myPic" />
    </div>
    <br>
    <?php    
        echo "Last updated " .$lastUpdated;
    ?> 
</center>

<!--Note: make sure you run the Rscript once manually to produce the lic-usage-plot.png file and chmod 777 it so that the website can now write-access it-->

</body>
</html>
