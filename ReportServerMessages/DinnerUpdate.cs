﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NServiceBus;

namespace ReportServerMessages
{
    [Serializable]
    public class DinnerUpdate : IMessage
    {
        public Guid MessageId;
        public Guid CommandMessageId;
        public int DinnerId;

    }
}
