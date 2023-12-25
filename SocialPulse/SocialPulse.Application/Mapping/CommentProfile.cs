using SocialPulse.Core;

namespace SocialPulse.Application
{
    public class CommentProfile : BaseProfile
    {
        public CommentProfile()
        {
            CreateMap<CommentDto, Comment>().ReverseMap();

            CreateMap<CommentUpsertDto, Comment>();
        }
    }
}
