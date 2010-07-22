using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NServiceBus;

namespace ReportUpdaterServer
{
    public class UserDinnerUpdate : IHandleMessages<ReportServerMessages.DinnerReservationUpdate>, IHandleMessages<ReportServerMessages.DinnerUpdate>, IHandleMessages<ReportServerMessages.UserUpdate>
    {
        public static IBus Bus { get; set; }

        public void Handle(ReportServerMessages.DinnerReservationUpdate message)
        {
            using (Systementor.Database.Repositories.IUnitOfWork uow = DB.DataContext.CreateUnitOfWork(true))
            {
                Dictionary<string, object> p = new Dictionary<string, object>();
                p.Add("dinner_id", message.DinnerId);
                uow.ExecuteNamedCommand("spUpdateDinnerUsers",p);
            }
            
                    

        }

        public void Handle(ReportServerMessages.DinnerUpdate message)
        {
            using (Systementor.Database.Repositories.IUnitOfWork uow = DB.DataContext.CreateUnitOfWork(true))
            {
                Dictionary<string, object> p = new Dictionary<string, object>();
                p.Add("dinner_id", message.DinnerId);
                uow.ExecuteNamedCommand("spUpdateDinner", p);

            }
        }

        public void Handle(ReportServerMessages.UserUpdate message)
        {
            using (Systementor.Database.Repositories.IUnitOfWork uow = DB.DataContext.CreateUnitOfWork(true))
            {
                Dictionary<string, object> p = new Dictionary<string, object>();
                p.Add("user_id", message.UserId);
                uow.ExecuteNamedCommand("spUpdateUser", p);
            }

        }
    }
}
