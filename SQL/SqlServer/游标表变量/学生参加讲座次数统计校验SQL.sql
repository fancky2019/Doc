select top 20 a.AppointmentId,b.ActiveTheme,b.StartTime,b.EndTime,b.ActiveAddress,c.AdminUserName,
                                                a.AddedTime,isnull(a.flag,0) as flag,a.FlagType,a.AppointmentNo,b.InviteSms,isnull(ParaRevenueMarketType.MarketTypeName,
                                                    case DCType --when 0 then '���۵���'
                                                    --when 1 then '��������'
                                                    --when 2 then '�г�����'
                                                    when 3 then '��Լ����' else '' end) as MarketTypeName   
                                                from UserAppointment as a
                                                left join Active as b on a.ActiveId =b.ActiveId
                                                left join SysUser as c on a.AddBy= c.AdminUserId
                                                left join ParaRevenueMarketType on ParaRevenueMarketType.MarketTypeId=a.MarketTypeId 
												where a.studentId='937F1E2D-4997-4144-B6B3-5963BAD2E6C0' 
                                                and a.IsDelete =0
												and b.IsDelete = 0 
												and isnull(a.flag,0)=1
												order by  a.AddedTime desc
