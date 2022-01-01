# IP_4_XfcePanel (V2.1)

![preview](https://github.com/Valzuun/IP4_4_XfcePanel/raw/V2.0/Images/IP4_4_XfcePanel.png)

Simple script to show your local / global IP in the Xfce Panel
also usefull to show your IP only or use as parameter 

Download IP_4_XfcePanel.sh  
make it executable (chmod +x)  
optional:  
&emsp;- create a folder of your choice  
&emsp;&emsp;- suggest: sudo mkdir /etc/ip4panel  
&emsp;- move the file to new folder (i.e. sudo mv IP_4_XfcePanel.sh /etc/ip4panel  
  
Add "new icon" to the panel (right click on panel)  
choose: "Generic Monitor"  
right click "properties" at new icon  
&emsp;Command: choose the downloaded (and moved) script  
&emsp;add Parameters (see below)  
&emsp;uncheck "Label"  
&emsp;Save  
  	
--> have fun!
  
Parameters:  
  
:{networkadapter} (needed for local ip) i.e. :eth0, :wlan1  
-l4: show local IP (IP4 format)  
-l6: show local IP (IP6 format)  
-g4: show global IP (IP4 format)  
-g6: show global IP (IP6 format)  
-hd: hide description  
-pure: no <> surrounding IP  
-help: show help  
