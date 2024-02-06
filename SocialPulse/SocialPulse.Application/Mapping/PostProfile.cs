using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class PostProfile : BaseProfile
    {
        public PostProfile()
        {
            CreateMap<PostDto, Post>().ReverseMap();

            CreateMap<PostUpsertDto, Post>()
                .ForMember(p=>p.Images, opt=>opt.MapFrom(src=>src.Images));
        }
    }
}
