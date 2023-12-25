using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class SubscriptionsService : BaseService<Subscription, SubscriptionDto, SubscriptionUpsertDto, SubscriptionSearchObject, ISubscriptionsRepository>, ISubscriptionsService
    {
        public SubscriptionsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<SubscriptionUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
