using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class NotificationProfile : BaseProfile
    {
        public NotificationProfile()
        {
            CreateMap<NotificationDto, Notification>().ReverseMap();

            CreateMap<NotificationUpsertDto, Notification>();
        }
    }
}
