﻿namespace SocialPulse.Core
{
    public class SubscriptionDto : BaseDto
    {
        public int UserId { get; set; }
        public UserDto User { get; set; } = null!;
        public bool Active { get; set; }
        public DateTime ExpirationDate { get; set; }
    }
}
