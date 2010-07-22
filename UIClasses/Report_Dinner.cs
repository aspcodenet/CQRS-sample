using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace UIClasses
{
    public class Report_Dinner
    {
        public Report_Dinner()
        {
            UsersComing = new HashSet<Report_User>();
        }
        public virtual int Dinner_Id { get; set; }
        public virtual DateTime Date { get; set; }
        public virtual string Location { get; set; }
        public virtual string Description { get; set; }
        public virtual int Organizer_User_id { get; set; }
        public virtual string Organizer_Fullname { get; set; }
        public virtual ICollection<Report_User> UsersComing { get; set; }
    }
}
