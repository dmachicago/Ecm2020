
function getLocalMachineName()
{
try {
    InetAddress addr = InetAddress.getLocalHost();

    // Get IP Address
    byte[] ipAddr = addr.getAddress();

    // Get hostname
    String hostname = addr.getHostName();
    } 
catch (UnknownHostException e) {
}

}

function alertText(text) {
    alert(text);
}

function sendText() {
    return "Notification from Java";
}

 function getHostIp() {
   try {
        java.net.InetAddress i ;
        i = java.net.InetAddress.getLocalHost();
        //System.out.println(i);                  // name and IP address
        //System.out.println(i.getHostName());    // name
        return i.getHostAddress(); // IP address only
   }
   catch(Error)
   {
        System.out.println(error.toString) ;
        return error.toString ;
   }
 }

 function getHostName() {
   try {
        java.net.InetAddress I = java.net.InetAddress.getLocalHost();
        //System.out.println(I);                  // name and IP address
        return I.getHostName();    // name
        //System.out.println(I.getHostAddress()); // IP address only
   }
   catch(Error)
   {
        System.out.println(error.toString) ;
        return error.toString ;
   }
 }

  function UserID() {
   try {
        return System.getProperty("user.name"); 
   }
   catch(Error)
   {
        System.out.println(error.toString) ;
        return error.toString ;
   }
 }

 function MachineName() {
   try {
    return InetAddress.getLocalHost().getHostName().toString ;
   }
   catch(Error)
   {
        System.out.println(error.toString) ;
        return error.toString ;
   }
 }