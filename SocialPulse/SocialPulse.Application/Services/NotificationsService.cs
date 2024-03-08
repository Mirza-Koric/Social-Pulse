using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class NotificationsService : BaseService<Notification, NotificationDto, NotificationUpsertDto, NotificationSearchObject, INotificationsRepository>, INotificationsService
    {
        public NotificationsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<NotificationUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
