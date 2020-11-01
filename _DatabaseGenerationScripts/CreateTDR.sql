USE [master]
GO

/****** Object:  Database [TDR]    Script Date: 7/28/2017 10:55:34 AM ******/
CREATE DATABASE [TDR] ON  PRIMARY 
( NAME = N'TDR', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\TDR.mdf' , SIZE = 9547776KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TDR_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\TDR_1.ldf' , SIZE = 21287424KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [TDR] SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TDR].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [TDR] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [TDR] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [TDR] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [TDR] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [TDR] SET ARITHABORT OFF 
GO

ALTER DATABASE [TDR] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [TDR] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [TDR] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [TDR] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [TDR] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [TDR] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [TDR] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [TDR] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [TDR] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [TDR] SET  DISABLE_BROKER 
GO

ALTER DATABASE [TDR] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [TDR] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [TDR] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [TDR] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [TDR] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [TDR] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [TDR] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [TDR] SET RECOVERY FULL 
GO

ALTER DATABASE [TDR] SET  MULTI_USER 
GO

ALTER DATABASE [TDR] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [TDR] SET DB_CHAINING OFF 
GO

ALTER DATABASE [TDR] SET  READ_WRITE 
GO


