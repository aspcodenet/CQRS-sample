using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace NerdDinnerDomain
{
    public class User
    {
        public virtual int Id { get; set; }
        public virtual string Forname { get; set; }
        public virtual string Surname { get; set; }
        public virtual DateTime Joined { get; set; }

    }
}
