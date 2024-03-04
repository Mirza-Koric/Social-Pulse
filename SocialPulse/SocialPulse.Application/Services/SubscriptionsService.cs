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

        public async Task PaySubscriptionAsync(int userId, CancellationToken cancellationToken = default)
        {
            var subscription = await CurrentRepository.GetByUserIdAsync(userId, cancellationToken);

            var newSub = new Subscription
            {
                UserId = userId,
                Active = true,
                ExpirationDate = DateTime.Now.AddMonths(1)
            };

            if (subscription == null)
            {
                await CurrentRepository.AddAsync(newSub, cancellationToken);
            }
            else 
            {
                CurrentRepository.Update(newSub);
            }

            await UnitOfWork.SaveChangesAsync(cancellationToken);
        }
    }
}
