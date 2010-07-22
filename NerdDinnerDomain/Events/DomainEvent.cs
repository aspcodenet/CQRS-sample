using System;
using DomainEventInfrastructure;


namespace NerdDinnerDomain.Events
{
    public static class DomainEvents
    {
          public static readonly DomainEvent<DinnerUserEventArgs> UserOptedInForDinnerEvent = 

                                               new DomainEvent<DinnerUserEventArgs>();

    }
}
