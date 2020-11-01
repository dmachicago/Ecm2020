Public Class clsTimeCalcs

    Public Function ElapsedTimeInMS(ByVal sTime As Date, ByVal eTime As Date) As Double

        Dim elapsed_time As TimeSpan = Nothing
        elapsed_time = eTime.Subtract(sTime)
        Dim txTotalTime As Double = elapsed_time.Milliseconds
        Return txTotalTime

    End Function

End Class
