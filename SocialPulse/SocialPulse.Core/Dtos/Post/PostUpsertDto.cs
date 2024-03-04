namespace SocialPulse.Core
{
    public class PostUpsertDto : BaseUpsertDto
    {
        public string Title { get; set; } = null!;
        public string Text { get; set; } = null!;
        public bool? IsAdvert { get; set; }

        public int UserId { get; set; }
        public int GroupId { get; set; }
        public int? TagId { get; set; }

        public ICollection<ImageUpsertDto>? Images { get; set; }

    }
}
