﻿namespace SocialPulse.Core
{
    public class MessageDto : BaseDto
    {
        public string Text { get; set; } = null!;

        public int UserId { get; set; }
        public User User { get; set; } = null!;
        public int ConversationId { get; set; }
        public Conversation Conversation { get; set; } = null!;
    }
}
