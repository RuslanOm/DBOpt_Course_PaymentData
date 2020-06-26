USE [PaymentData]
GO

-- ��������� ��������� ����������
DECLARE @r_payee UNIQUEIDENTIFIER
DECLARE @r_payer UNIQUEIDENTIFIER
DECLARE @r_project UNIQUEIDENTIFIER

SET @r_payee = (SELECT TOP (1) PaymentParticipant.Oid FROM dbo.PaymentParticipant ORDER BY RAND())
SET @r_payer = (SELECT TOP (1) PaymentParticipant.Oid FROM dbo.PaymentParticipant ORDER BY RAND())
SET @r_project = (SELECT TOP (1) dbo.Project.Oid FROM dbo.Project ORDER BY RAND())

-- ��������� ������ � ����� ����������
-- � �����������
UPDATE PaymentParticipant
SET Balance = dbo.F_CalculatePaymentParticipantBalance(@r_payer)

-- � ����������
UPDATE PaymentParticipant
SET Balance = dbo.F_CalculatePaymentParticipantBalance(@r_payee)
	
-- ��������� ������ � ����� �������	
UPDATE Project
SET BalanceByMaterial = dbo.F_CalculateBalanceByMaterial(@r_project),
BalanceByWork = dbo.F_CalculateBalanceByWork(@r_project),	
Balance = dbo.F_CalculateProjectBalance(@r_project)	
GO