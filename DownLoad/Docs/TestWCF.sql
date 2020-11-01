/****** Script for SelectTopNRows command from SSMS  ******/
SELECT * FROM [ECM.SecureLogin].[dbo].[SecureAttach] where RowID = 23


  update [ECM.SecureLogin].[dbo].[SecureAttach]
  set [SVCCLCArchive_Endpoint] = 'http://192.168.0.13/archive/SVCCLCArchive.svc'
  where RowID = 23

  update [ECM.SecureLogin].[dbo].[SecureAttach]
  set [SVCCLCArchive_Endpoint] = 'http://localhost:53407/SVCCLCArchive.svc'
  where RowID = 23
  
  update [ECM.SecureLogin].[dbo].[SecureAttach]
  set [SVCDownload_Endpoint] = 'http://localhost:45467/SVCclcDownload.svc'
  where RowID = 23

  update [ECM.SecureLogin].[dbo].[SecureAttach]
  set [SVCDownload_Endpoint] = 'http://192.168.0.13/SVCclcDownload/SVCclcDownload.svc'
  where RowID = 23

  --*****************************************************************************************
  update [ECM.SecureLogin].[dbo].[SecureAttach]
  set [SVCGateway_Endpoint] = 'http://localhost:1550/SVCGateway.svc'
  where RowID = 23

  update [ECM.SecureLogin].[dbo].[SecureAttach]
  set [SVCGateway_Endpoint] = 'http://192.168.0.13/SecureAttachAdminSvc/SVCGateway.svc'
  where RowID = 23