using AutoMapper;
using FluentValidation;
using SocialPulse.Application.Interfaces;
using SocialPulse.Core;
using SocialPulse.Infrastructure;
using SocialPulse.Infrastructure.Interfaces;

namespace SocialPulse.Application
{
    public class ImagesService : BaseService<Image, ImageDto, ImageUpsertDto, BaseSearchObject, IImagesRepository>, IImagesService
    {
        public ImagesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ImageUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
