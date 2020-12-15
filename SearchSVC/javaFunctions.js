// ***********************************************************************
// Assembly         : EcmCloudWcf.Web
// Author           : wdale
// Created          : 06-28-2020
//
// Last Modified By : wdale
// Last Modified On : 06-28-2020
// ***********************************************************************
// <copyright file="javaFunctions.js" company="ECM Library,LLC">
//     Copyright @ECM Library 2020 all rights reserved.
// </copyright>
// <summary></summary>
// ***********************************************************************

function getLocalMachineName()
{
/// <summary>
/// Gets the name of the local machine.
/// </summary>
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
    /// <summary>
    /// Alerts the text.
    /// </summary>
    /// <param name="text">The text.</param>
    alert(text);
}

function sendText() {
    /// <summary>
    /// Sends the text.
    /// </summary>
    return "Notification from Java";
}

 function getHostIp() {
   /// <summary>
   /// Gets the host ip.
   /// </summary>
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
   /// <summary>
   /// Gets the name of the host.
   /// </summary>
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
   /// <summary>
   /// Users the identifier.
   /// </summary>
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
   /// <summary>
   /// Machines the name.
   /// </summary>
   try {
    return InetAddress.getLocalHost().getHostName().toString ;
   }
   catch(Error)
   {
        System.out.println(error.toString) ;
        return error.toString ;
   }
 }