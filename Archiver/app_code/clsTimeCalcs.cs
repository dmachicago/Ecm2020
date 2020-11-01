using System;
using MODI;

namespace EcmArchiver
{
    public class clsTimeCalcs
    {
        public double ElapsedTimeInMS(DateTime sTime, DateTime eTime)
        {
            TimeSpan elapsed_time = default;
            elapsed_time = eTime.Subtract(sTime);
            double txTotalTime = elapsed_time.Milliseconds;
            return txTotalTime;
        }
    }
}