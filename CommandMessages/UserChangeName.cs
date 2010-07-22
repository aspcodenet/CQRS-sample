using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NServiceBus;

namespace CommandMessages
{
    [Serializable]
    public class UserChangeName : IMessage
    {
        public System.Guid MessageGuid { get; set; }
        public int UserId { get; set; }
        public string Forname { get; set; }
        public string Surname { get; set; }
    }
}
