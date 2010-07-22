using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NServiceBus;

namespace CommandServer
{
    public class UserChangeName : IHandleMessages<CommandMessages.UserChangeName>
    {
        public static IBus Bus { get; set; }
        public void Handle(CommandMessages.UserChangeName message)
        {
            Console.WriteLine("We should not change name to " + message.Forname + " " + message.Surname);
            using (Systementor.Database.Repositories.IUnitOfWork uow = DB.DataContext.CreateUnitOfWork(true))
            {
                //First - ask yourself does this *really* belong to domain model???
                //NOOOO - this behaviour is something thats not very hard to do, not changes frequently, 
                //not specific to our business, but rather something all businesses probably have
                //so a transaction script is fine...
                Systementor.Database.Repositories.IRepository<NerdDinnerDomain.User> rep = uow.CreateRepository<NerdDinnerDomain.User>();
                //Does it exists already?
                int cnt = rep.Count(p => p.Surname == message.Surname && p.Forname == message.Forname && p.Id != message.UserId);
                if ( cnt > 0 )
                    return;
                NerdDinnerDomain.User oUser = rep.Get(p => p.Id == message.UserId);
                if (oUser == null) //Not much to do, user has disappeared
                    return;
                oUser.Forname = message.Forname;
                oUser.Surname = message.Surname;

                Bus.Send(new ReportServerMessages.UserUpdate { CommandMessageId = message.MessageGuid, MessageId = Guid.NewGuid(), UserId = oUser.Id });
                //Saving is automatically when going out of scope since we're using unitofwork(true)
            }
        }

    }
}
