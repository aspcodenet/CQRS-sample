using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CommandServer.DomainEvents
{
    public class GenericHandler
    {
        public static void Register()
        {
            NerdDinnerDomain.Events.DomainEvents.UserOptedInForDinnerEvent.Register(UserOptedInForDinnerHandler);
        }

        private static Action<NerdDinnerDomain.Events.DinnerUserEventArgs> UserOptedInForDinnerHandler = delegate(NerdDinnerDomain.Events.DinnerUserEventArgs args)
        {
            //So what do we do when a user really is added to a dinner ???
            //We simple Post TWO new messages to our own queue, one saying send email to the "optin user" since he opted into the dinner
            //second saying send email to the arranging user that user xxx has opted in 
            //However if user=owner just send second mail
            
            //Please note that hewre we DONT send. We just code the appropriate actions to take when this
            //domain event happen
            //i.e we just post new messages which another handler will take care of

            //We should of course get the email from the useraccount table etc but we are not storing
            //so here we just fake it

            string fromemail = "info@testabc123.com";
            string fromname = "system info";
            using (Systementor.Database.Repositories.IUnitOfWork uow = DB.DataContext.CreateUnitOfWork(false))
            {
                Systementor.Database.Repositories.IRepository<NerdDinnerDomain.User> rep = uow.CreateRepository<NerdDinnerDomain.User>();
                Systementor.Database.Repositories.IRepository<NerdDinnerDomain.Dinner> repDinner = uow.CreateRepository<NerdDinnerDomain.Dinner>();
                NerdDinnerDomain.Dinner oDinner = repDinner.Get(p => p.Id == args.DinnerId);

                NerdDinnerDomain.User oUser = rep.Get(p => p.Id == args.User_Id_Opted_In);
                NerdDinnerDomain.User o = rep.Get(p => p.Id == args.User_Id_Opted_In);
                if (args.Owner_User_id != args.User_Id_Opted_In)
                {
                    string toemail = oUser.Forname + "." + oUser.Surname + "@" + args.Owner_User_id.ToString() + ".com";
                    string toname = oUser.Forname + " " + oUser.Surname;
                    string message = "You have registered for dinner at " + oDinner.Location + " " + oDinner.Date.ToString();
                    MessageEndpoint.Bus.Send(new CommandMessages.External.SendMail { MessageGuid = Guid.NewGuid(), FromEmail = fromemail, FromName = fromname, ToEmail = toemail, ToName = toname, Header = "You opted in for a dinner", Message=message });
                }
                //Message to owner
                NerdDinnerDomain.User oUserOwner = rep.Get(p => p.Id == args.Owner_User_id);
                string toemailowner = oUserOwner.Forname + "." + oUserOwner.Surname + "@" + oUserOwner.Id.ToString() + ".com";
                string tonameowner = oUserOwner.Forname + " " + oUserOwner.Surname;
                string messageowner =  oUser.Forname + " " + oUser.Surname + " have registered for the dinner you are arranging at " + oDinner.Location + " " + oDinner.Date.ToString();
                MessageEndpoint.Bus.Send(new CommandMessages.External.SendMail { MessageGuid = Guid.NewGuid(), FromEmail = fromemail, FromName = fromname, ToEmail = toemailowner, ToName = tonameowner, Header = "Someone coming to your dinner", Message = messageowner });


                
            }




        };

  

    }
}
