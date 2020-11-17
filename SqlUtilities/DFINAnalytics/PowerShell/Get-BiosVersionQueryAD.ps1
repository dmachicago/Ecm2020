#Get-BiosVersionQueryAD.ps1

Import-Module -Name ActiveDirectory

Get-ADComputer -filter * |

Foreach-Object {

 Get-WmiObject -Class win32_bios -cn $_.name -EA silentlyContinue |

 Select-Object __Server, Manufacturer, Version } |

Format-Table -Property * -AutoSize