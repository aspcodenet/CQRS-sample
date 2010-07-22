using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NServiceBus;

namespace GUI.Communications
{
    public class CommandBus 

    {
        public static IBus Bus { get; set; }
        public static void Init()
        {
            Bus = NServiceBus.Configure.With()
                //.CastleWindsorBuilder()
                .DefaultBuilder()
                .XmlSerializer()
                .MsmqTransport()
                    .IsTransactional(true)
                .UnicastBus()
                    .ImpersonateSender(false)
                .CreateBus()
                .Start();

        }

        

        public static Guid UserChangeName(int UserId, string Forname, string LastName)
        {
            Guid g = Guid.NewGuid();;
            Bus.Send<CommandMessages.UserChangeName>(m =>
            {
                m.MessageGuid = g;
                m.Forname = Forname;
                m.UserId = UserId;
                m.Surname = LastName;
            });
            return g;
        }



        public void Stop()
        {
        }

        internal static Guid UserOptInForDinner(int userid, int dinnerid)
        {
            Guid g = Guid.NewGuid(); ;
            CommandMessages.UserOptInForDinner mess = new CommandMessages.UserOptInForDinner { DinnerId = dinnerid, MessageGuid = g, UserId = userid };
            Bus.Send(mess);
            return g;
        }
    }
}
