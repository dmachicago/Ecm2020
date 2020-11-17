select 'DictEmails.add("' + column_name + '", ' + column_name + ')' from INFORMATION_SCHEMA.COLUMNS where table_name = 'Email'
select 'DictContent.add("' + column_name + '", ' + column_name + ')' from INFORMATION_SCHEMA.COLUMNS where table_name = 'DataSource'

select 'FileDetails.' + column_name +' = "XX" 'from INFORMATION_SCHEMA.COLUMNS where table_name = 'DataSource'

select 'DIM ' + column_name + ' as string = tDict("'+column_name+'")'  from INFORMATION_SCHEMA.COLUMNS where table_name = 'DataSource'

Dim sql As String = " INSERT INTO tblZipCode([ZIPCODE], [STATE], [CITY], [TestDate]) VALUES(@ZIPCODE, @STATE, @CITY), @TestDate"

select column_name+',' from INFORMATION_SCHEMA.COLUMNS where table_name = 'DataSource'
select '@'+ column_name +',' from INFORMATION_SCHEMA.COLUMNS where table_name = 'DataSource'


select 'DIM ' + column_name + ' as string = "" '  from INFORMATION_SCHEMA.COLUMNS where table_name = 'DataSource'
select 'DIM ' + column_name + ' as string = "" '  from INFORMATION_SCHEMA.COLUMNS where table_name = 'Email'

select 'Public ' + column_name + ' as string = "" '  from INFORMATION_SCHEMA.COLUMNS where table_name = 'Email'

select 'command.Parameters.Add(New SqlParameter("@'+column_name+'", '+column_name+'))' from INFORMATION_SCHEMA.COLUMNS where table_name = 'DataSource'
select 'command.Parameters.AddWithValue("@'+column_name+'", '+column_name+')' from INFORMATION_SCHEMA.COLUMNS where table_name = 'DataSource'

select column_name + ' = @' + column_name +',' from INFORMATION_SCHEMA.COLUMNS where table_name = 'DataSource'

select 'Case "' + column_name + '"' + char(10) +
        'tval = DictEmails("' +column_name+'")'
from INFORMATION_SCHEMA.COLUMNS where table_name = 'Email'

select 'Case "' + column_name + '"' + char(10) +
        'tval = DictContent("' +column_name+'")'
from INFORMATION_SCHEMA.COLUMNS where table_name = 'DataSource'

select 'function pull_' + column_name + '(SourceGuid as string) as string ' + char(10) +
		' dim MySql as string = ""' + char(10) +
		' MySql = "select ' + column_name + ' from DataSource where SourceGuid = ''SourceGuid''"' + char(10) +
		'dim tval as string = "" ' + char(10) +
		'Dim CS as string = db.getConnStr()' + char(10) +
		'Dim CONN As New SqlConnection(CS)' + char(10) +
		'CONN.Open()'  + char(10) +
		'Dim command As New SqlCommand(S, CONN)' + char(10) +
		'rsdata = command.ExecuteReader()' + char(10) +
        'Dim RSData As SqlDataReader = Nothing' + char(10) +
        'Dim CONN As New SqlConnection(CS)' + char(10) +
        'CONN.Open()' + char(10) +
        'Dim command As New SqlCommand(MySql, CONN)' + char(10) +
        'RSData = command.ExecuteReader()' + char(10) +
        'Try' + char(10) +
        '    If RSData.HasRows Then' + char(10) +
        '        RSData.Read()' + char(10) +
        '        tval = RSData.GetValue(0).ToString()' + char(10) +
        '    End If' + char(10) +
        'Catch ex As Exception' + char(10) +
        '    Console.WriteLine("ERROR 00A1: " + ex.Message)' + char(10) +
        '    tval = ""' + char(10) +
        'Finally' + char(10) +
        '    If RSData.IsClosed Then' + char(10) +
        '    Else' + char(10) +
        '        RSData.Close()' + char(10) +
        '    End If' + char(10) +
        '    RSData = Nothing' + char(10) +
        '    If CONN.State = ConnectionState.Open Then' + char(10) +
        '        CONN.Close()' + char(10) +
        '    End If' + char(10) +
        '    CONN.Dispose()' + char(10) +
        '    command.Dispose()' + char(10) +
        'End Try' + char(10) +
        'GC.Collect()' + char(10) +
        'GC.WaitForPendingFinalizers()' + char(10) +
		' ' + char(10) +
        'Return tval' + char(10) +
		'END Function'
from INFORMATION_SCHEMA.COLUMNS where table_name = 'DataSource'

