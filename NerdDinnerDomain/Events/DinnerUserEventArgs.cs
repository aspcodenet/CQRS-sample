using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace NerdDinnerDomain.Events
{
    public class DinnerUserEventArgs
    {
        public int DinnerId;
        public int Owner_User_id;
        public int User_Id_Opted_In;
    }
}
