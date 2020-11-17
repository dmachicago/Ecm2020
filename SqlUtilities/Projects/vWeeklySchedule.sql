/* Course Schedule */
create view vWeeklySchedule as 
SELECT     ptms_Course.CourseTitle, ptms_Course.CourseID, ptms_Provider.ProviderName, ptms_CourseSchedule.StartTime, 
                      ptms_CourseSchedule.EndTime, ptms_CourseLocation.LocationCode, ptms_CourseSchedule.StartDate, ptms_CourseSchedule.EndDate,
                      ptms_Course.CourseDescription
FROM         ptms_Course INNER JOIN
                      ptms_CourseProvider ON ptms_Course.CourseID = ptms_CourseProvider.CourseID INNER JOIN
                      ptms_Provider ON ptms_CourseProvider.ProviderID = ptms_Provider.ProviderID INNER JOIN
                      ptms_CourseSchedule ON ptms_Course.CourseID = ptms_CourseSchedule.CourseID INNER JOIN
                      ptms_CourseLocation ON ptms_CourseSchedule.LocationCode = ptms_CourseLocation.LocationCode
