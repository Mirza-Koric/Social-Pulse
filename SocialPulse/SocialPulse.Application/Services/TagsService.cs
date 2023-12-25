using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class TagsService : BaseService<Tag, TagDto, TagUpsertDto, TagSearchObject, ITagsRepository>, ITagsService
    {
        public TagsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<TagUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
