
function showDone($JobName){
    Write-Output "***************************************";
    Write-Output "---> $JobName DONE <---";
    Write-Output "***************************************";
}

function getRunID (){
        $EndDate=(GET-DATE)
        $StartDate=[datetime]”01/01/2019 00:00”
        $timediff = NEW-TIMESPAN –Start $StartDate –End $EndDate;
        return [Math]::Truncate($timediff.TotalMinutes)        
}
