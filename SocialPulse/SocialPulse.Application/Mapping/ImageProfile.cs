using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class ImageProfile : BaseProfile
    {
        public ImageProfile()
        {
            CreateMap<ImageDto, Image>().ReverseMap();

            CreateMap<ImageUpsertDto, Image>();
        }
    }
}
