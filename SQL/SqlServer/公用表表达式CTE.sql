--一个CTE
use [Procurement]
GO
WITH UserSubjects_CTE  AS (
SELECT us.[Id], us.[OrderNo],us.[OrganizeName],us.[OrderFrom],us.[UsedPowerType],us.[IndustryType],us.[AgreementStatus],us.[UserLevel],
        us.[HasLicence],us.[IsQualifiedBuyer],us.[AgreementNumber],c.Id ContractsID,c.[Status] ContractStatus , i.CategoryName
        FROM [Procurement].[dbo].[UserSubjects] us
        left join [dbo].[UserRequirements] ur on us.AgreementNumber=ur.AgreementNumber
        left  join [dbo].[ContractsSignManage] cs on ur.Id=cs.UserRequireId 
        left  join [dbo].[Contracts] c on c.ContractSignId=cs.Id
        left  join [INFRASTRUCTURE].[INFRASTRUCTURE].[IndustryCategory] i on us.IndustryType =i.Id
 where us.BrokerId='ec32f163-3510-447f-894d-404f5ac1b1fe'
 order by 1
 OFFSET 10*(1-1) ROWS FETCH NEXT 10 ROWS ONLY
)
SELECT *  FROM UserSubjects_CTE

--多个CTE
use [Procurement]
GO
WITH UserSubjects_CTE  AS (
SELECT us.[Id], us.[OrderNo],us.[OrganizeName],us.[OrderFrom],us.[UsedPowerType],us.[IndustryType],us.[AgreementStatus],us.[UserLevel],
        us.[HasLicence],us.[IsQualifiedBuyer],us.[AgreementNumber],c.Id ContractsID,c.[Status] ContractStatus , i.CategoryName
        FROM [Procurement].[dbo].[UserSubjects] us
        left join [dbo].[UserRequirements] ur on us.AgreementNumber=ur.AgreementNumber
        left  join [dbo].[ContractsSignManage] cs on ur.Id=cs.UserRequireId 
        left  join [dbo].[Contracts] c on c.ContractSignId=cs.Id
        left  join [INFRASTRUCTURE].[INFRASTRUCTURE].[IndustryCategory] i on us.IndustryType =i.Id
 where us.BrokerId='ec32f163-3510-447f-894d-404f5ac1b1fe'
 order by 1
 OFFSET 10*(1-1) ROWS FETCH NEXT 10 ROWS ONLY
)
,UserRequirements_CTE([Id],[CreationDate],[AgreementNumber]) AS(
SELECT  [Id],[CreationDate],[AgreementNumber] FROM [UserRequirements]
)
SELECT *  FROM UserSubjects_CTE us
JOIN  UserRequirements_CTE ur on us.AgreementNumber=ur.AgreementNumber

