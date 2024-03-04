namespace SocialPulse.Infrastructure.Interfaces
{
    public class BaseSearchObject
    {
        public int PageNumber { get; set; } = 1;
        public int PageSize { get; set; } = 10;
        public bool? IsDeleted { get; set; }
        public DateTime? CreatedAt { get; set; }
    }
}
