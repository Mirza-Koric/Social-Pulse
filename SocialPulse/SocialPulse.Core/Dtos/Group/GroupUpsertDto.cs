namespace SocialPulse.Core
{
    public class GroupUpsertDto : BaseUpsertDto
    {
        public string Name { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}
