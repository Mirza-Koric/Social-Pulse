﻿using System.Text.Json.Serialization;

namespace SocialPulse.Core
{
    public class Like : BaseEntity
    {
        public bool Type { get; set; }

        public int PostId { get; set; }
        public Post Post { get; set; } = null!;
        public int UserId { get; set; }
        public User User { get; set; } = null!;
    }
}
