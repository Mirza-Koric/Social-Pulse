using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace SocialPulse.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class first : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Conversations",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Conversations", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Groups",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Groups", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Tags",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Tags", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Username = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PasswordSalt = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Role = table.Column<int>(type: "int", nullable: false),
                    BirthDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Messages",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Text = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    ConversationId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Messages", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Messages_Conversations_ConversationId",
                        column: x => x.ConversationId,
                        principalTable: "Conversations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Messages_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Posts",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Text = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    GroupId = table.Column<int>(type: "int", nullable: false),
                    TagId = table.Column<int>(type: "int", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Posts", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Posts_Groups_GroupId",
                        column: x => x.GroupId,
                        principalTable: "Groups",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Posts_Tags_TagId",
                        column: x => x.TagId,
                        principalTable: "Tags",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Posts_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Questions",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Text = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Questions", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Questions_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Reports",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ReportReason = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ReporterId = table.Column<int>(type: "int", nullable: false),
                    ReportedId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Reports", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Reports_Users_ReportedId",
                        column: x => x.ReportedId,
                        principalTable: "Users",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Reports_Users_ReporterId",
                        column: x => x.ReporterId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Subscriptions",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    Active = table.Column<bool>(type: "bit", nullable: false),
                    ExpirationDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Subscriptions", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Subscriptions_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UserConversations",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    ConversationId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserConversations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserConversations_Conversations_ConversationId",
                        column: x => x.ConversationId,
                        principalTable: "Conversations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserConversations_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Comments",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Text = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PostId = table.Column<int>(type: "int", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Comments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Comments_Posts_PostId",
                        column: x => x.PostId,
                        principalTable: "Posts",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Comments_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Images",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Data = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    ContentType = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PostId = table.Column<int>(type: "int", nullable: true),
                    MessageId = table.Column<int>(type: "int", nullable: true),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Images", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Images_Messages_MessageId",
                        column: x => x.MessageId,
                        principalTable: "Messages",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Images_Posts_PostId",
                        column: x => x.PostId,
                        principalTable: "Posts",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Likes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Type = table.Column<bool>(type: "bit", nullable: false),
                    PostId = table.Column<int>(type: "int", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Likes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Likes_Posts_PostId",
                        column: x => x.PostId,
                        principalTable: "Posts",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Likes_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Answers",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Text = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    AdminId = table.Column<int>(type: "int", nullable: false),
                    QuestionId = table.Column<int>(type: "int", nullable: false),
                    IsDeleted = table.Column<bool>(type: "bit", nullable: false, defaultValue: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ModifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Answers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Answers_Questions_QuestionId",
                        column: x => x.QuestionId,
                        principalTable: "Questions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Answers_Users_AdminId",
                        column: x => x.AdminId,
                        principalTable: "Users",
                        principalColumn: "Id");
                });

            migrationBuilder.InsertData(
                table: "Conversations",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null },
                    { 2, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null },
                    { 3, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null },
                    { 4, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null }
                });

            migrationBuilder.InsertData(
                table: "Groups",
                columns: new[] { "Id", "CreatedAt", "Description", "ModifiedAt", "Name" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), "Sports news and highlight from all major sports organizations", null, "Sports" },
                    { 2, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), "A place for major news from around the world", null, "News" },
                    { 3, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), "The #1 community for music lovers", null, "Music" },
                    { 4, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), "The goal of this group is to provide a place for discussion and news about films", null, "Movies" }
                });

            migrationBuilder.InsertData(
                table: "Tags",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "Name" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "Long" },
                    { 2, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "Short" },
                    { 3, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "Discussion" },
                    { 4, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "Media" }
                });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "BirthDate", "CreatedAt", "Email", "ModifiedAt", "PasswordHash", "PasswordSalt", "Role", "Username" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), "user@mail.com", null, "KnHtwSBaEBRQ4kirxu8qLLU+20BraHV95Aj4JJcTZyQ=", "0dUI00v6BWmtxp8JCAyw9w==", 0, "TestUser" },
                    { 2, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), "user2@mail.com", null, "KnHtwSBaEBRQ4kirxu8qLLU+20BraHV95Aj4JJcTZyQ=", "0dUI00v6BWmtxp8JCAyw9w==", 1, "TestUser2" },
                    { 3, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), "user3@mail.com", null, "KnHtwSBaEBRQ4kirxu8qLLU+20BraHV95Aj4JJcTZyQ=", "0dUI00v6BWmtxp8JCAyw9w==", 1, "TestUser3" },
                    { 4, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), "user4@mail.com", null, "KnHtwSBaEBRQ4kirxu8qLLU+20BraHV95Aj4JJcTZyQ=", "0dUI00v6BWmtxp8JCAyw9w==", 1, "TestUser4" },
                    { 5, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), "user5@mail.com", null, "KnHtwSBaEBRQ4kirxu8qLLU+20BraHV95Aj4JJcTZyQ=", "0dUI00v6BWmtxp8JCAyw9w==", 1, "TestUser5" }
                });

            migrationBuilder.InsertData(
                table: "Messages",
                columns: new[] { "Id", "ConversationId", "CreatedAt", "ModifiedAt", "Text", "UserId" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2023, 2, 1, 0, 1, 0, 0, DateTimeKind.Local), null, "Just finished a killer workout. What's up with you?", 2 },
                    { 2, 1, new DateTime(2023, 2, 1, 0, 2, 0, 0, DateTimeKind.Local), null, "I'm just chilling and catching up on some reading. Any exciting plans for the weekend?", 3 },
                    { 3, 1, new DateTime(2023, 2, 1, 0, 3, 0, 0, DateTimeKind.Local), null, "Thinking of hitting the trails for a hike. Nature vibes, you know? What about you?", 2 },
                    { 4, 1, new DateTime(2023, 2, 1, 0, 4, 0, 0, DateTimeKind.Local), null, "That sounds awesome! I might check out a new coffee shop downtown. Any book recommendations?", 3 },
                    { 5, 1, new DateTime(2023, 2, 1, 0, 5, 0, 0, DateTimeKind.Local), null, "Absolutely! \"The Night Circus\" is a magical read. What kind of books are you into lately?", 2 },
                    { 6, 1, new DateTime(2023, 2, 1, 0, 6, 0, 0, DateTimeKind.Local), null, "I'm on a sci-fi kick lately. Just finished \"Dune\" — epic world-building! Got any sci-fi gems in mind?", 3 },
                    { 7, 1, new DateTime(2023, 2, 1, 0, 6, 0, 0, DateTimeKind.Local), null, "Nice choice! \"Neuromancer\" is a classic cyberpunk adventure. What's your favorite sci-fi element?", 2 },
                    { 8, 1, new DateTime(2023, 2, 1, 0, 7, 0, 0, DateTimeKind.Local), null, "Definitely the exploration of AI and its impact on society. Love those thought-provoking themes. What about you?", 3 },
                    { 9, 1, new DateTime(2023, 2, 1, 0, 8, 0, 0, DateTimeKind.Local), null, "Same here! The ethical dilemmas in AI stories always get me thinking. Changing topics, any movie plans for the night?", 2 },
                    { 10, 1, new DateTime(2023, 2, 1, 0, 9, 0, 0, DateTimeKind.Local), null, "Just downloaded a new indie film. \"Eternal Sunshine of the Spotless Mind.\" Heard it's a mind-bender. Have you seen it?", 3 },
                    { 11, 1, new DateTime(2023, 2, 1, 0, 10, 0, 0, DateTimeKind.Local), null, "Absolutely love that one! Jim Carrey in a different light, you know?", 2 },
                    { 12, 1, new DateTime(2023, 2, 1, 0, 11, 0, 0, DateTimeKind.Local), null, "Enjoy the journey! Let me know how you find it.", 2 },
                    { 13, 1, new DateTime(2023, 2, 1, 0, 12, 0, 0, DateTimeKind.Local), null, "Thanks. Enjoy your hike and have a fantastic weekend!", 3 },
                    { 14, 2, new DateTime(2023, 2, 1, 0, 1, 0, 0, DateTimeKind.Local), null, "Just got tickets to that new comedy show downtown. Interested in joining?", 4 },
                    { 15, 2, new DateTime(2023, 2, 1, 0, 2, 0, 0, DateTimeKind.Local), null, "Sounds fun! Count me in. When's the show?", 5 },
                    { 16, 2, new DateTime(2023, 2, 1, 0, 3, 0, 0, DateTimeKind.Local), null, "It's this Saturday at 8 PM. Perfect way to kick off the weekend!", 4 },
                    { 17, 2, new DateTime(2023, 2, 1, 0, 4, 0, 0, DateTimeKind.Local), null, "Awesome! Looking forward to it. Anything else happening this week?", 5 },
                    { 18, 2, new DateTime(2023, 2, 1, 0, 5, 0, 0, DateTimeKind.Local), null, "Not much, just work and the usual. Any movie recommendations for a cozy night in?", 4 },
                    { 19, 2, new DateTime(2023, 2, 1, 0, 6, 0, 0, DateTimeKind.Local), null, "How about \"The Grand Budapest Hotel\"? Quirky and entertaining!", 5 },
                    { 20, 2, new DateTime(2023, 2, 1, 0, 7, 0, 0, DateTimeKind.Local), null, "Great pick! I'll check it out. See you Saturday!", 4 },
                    { 21, 2, new DateTime(2023, 2, 1, 0, 8, 0, 0, DateTimeKind.Local), null, "Can't wait! See you then!", 5 },
                    { 22, 3, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "Hello?", 2 },
                    { 23, 3, new DateTime(2023, 2, 1, 0, 1, 0, 0, DateTimeKind.Local), null, "Hi.", 4 },
                    { 24, 4, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "Hello?", 3 },
                    { 25, 4, new DateTime(2023, 2, 1, 0, 1, 0, 0, DateTimeKind.Local), null, "Hi!", 5 }
                });

            migrationBuilder.InsertData(
                table: "Posts",
                columns: new[] { "Id", "CreatedAt", "GroupId", "ModifiedAt", "TagId", "Text", "Title", "UserId" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), 1, null, null, "Whether it's a slam dunk, a goal celebration, or a touchdown dance, the adrenaline rush of sports is unmatched! What's your favorite sport, and which team has your heart? Drop your cheers in the comments below!", "Game On!", 2 },
                    { 2, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), 1, null, null, "Sundays are made for epic sports battles! Which team are you cheering for today, and who's your MVP? Let the banter begin as we countdown to the final whistle. Game on, sports enthusiasts!", "Sunday Showdown!", 2 },
                    { 3, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), 1, null, 3, "Whether it's hitting the gym, pounding the pavement, or mastering a new yoga pose, let's celebrate the fitness journey together! Share your favorite workout routine or fitness tips that keep you motivated. Let's inspire each other to break a sweat!", "Fitness Fanatics Unite!", 3 },
                    { 4, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), 2, null, null, "From global events to local buzz, staying updated is key! What news story caught your attention today? Share your thoughts and let's discuss the stories shaping our world. Knowledge is power!", "Headlines Unveiled: Stay Informed!", 3 },
                    { 5, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), 2, null, null, "From groundbreaking discoveries to viral trends, what's been catching your eye in the news lately? Let's dive deep into the headlines and share our thoughts on the stories shaping our world. What's your take?", "Trending Topics Alert!", 4 },
                    { 6, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), 2, null, null, "In a world full of headlines, let's focus on the positive stories that warm our hearts. Share a recent news piece that made you smile or inspired you. Together, let's spread positivity and celebrate the good vibes!", "Positive News Vibes Only!", 4 },
                    { 7, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), 3, null, null, "Music is the soundtrack of our lives, and every beat tells a story. What song is playing on repeat for you right now? Share your current music obsession and let's create a playlist together! ", "Melody Magic", 5 },
                    { 8, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), 3, null, 3, "Mondays are for reminiscing! Share a musical memory that takes you back in time. Whether it's a concert, a road trip playlist, or a special dance moment, let's rewind the clock and relive the magic together.", "Musical Memories Monday!", 3 },
                    { 9, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), 3, null, null, "Let's shake things up! Challenge accepted: switch to a music genre you rarely explore. Share a song or artist from the new genre you're diving into, and let's see who discovers their next favorite tune!", "Genre Swap Challenge!", 4 },
                    { 10, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), 4, null, null, "Whether it's a blockbuster hit or a hidden gem, what movie stole the show for you recently? Share your top picks, and let's swap recommendations for the ultimate movie night!", "Movie Buff Vibes", 2 },
                    { 11, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), 4, null, 3, "Dive into the archives with me! What classic movie holds a special place in your heart? Share your all-time favorite cinematic masterpiece, and let's reminisce about the golden era of film together.", "Cinematic Classics Countdown!", 3 },
                    { 12, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), 4, null, null, "Planning a movie marathon this weekend? Share your must-watch movie list, and let's curate the ultimate movie night lineup! From comedies to dramas, let's make it an unforgettable cinematic experience.", "Movie Marathon Madness!", 5 }
                });

            migrationBuilder.InsertData(
                table: "Questions",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "Text", "UserId" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "I'm curious about the future updates! Can you give us a sneak peek into any upcoming features or improvements?", 2 },
                    { 2, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "How do you ensure the safety and privacy of user data on the platform?", 2 },
                    { 3, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "Are there any plans for community events or challenges on the platform? It would be awesome to engage with other users in a fun way!", 3 },
                    { 4, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "How does content moderation work to ensure a positive and respectful environment?", 3 },
                    { 5, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "I'm curious about the technology behind the scenes. What kind of AI models power the platform, and how do you ensure they're unbiased?", 2 },
                    { 6, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "Are there plans to expand the app to support different languages and cultures?", 3 },
                    { 7, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "How can users contribute to the development of the platform? Any plans for a user feedback program?", 4 },
                    { 8, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, "In case of technical issues or bugs, what's the best way for users to report them and get assistance?", 4 }
                });

            migrationBuilder.InsertData(
                table: "UserConversations",
                columns: new[] { "Id", "ConversationId", "CreatedAt", "ModifiedAt", "UserId" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 2 },
                    { 2, 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 3 },
                    { 3, 2, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 4 },
                    { 4, 2, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 5 },
                    { 5, 3, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 2 },
                    { 6, 3, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 4 },
                    { 7, 4, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 3 },
                    { 8, 4, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 5 }
                });

            migrationBuilder.InsertData(
                table: "Answers",
                columns: new[] { "Id", "AdminId", "CreatedAt", "ModifiedAt", "QuestionId", "Text" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 1, "Absolutely! We're thrilled about the upcoming updates. Get ready for enhanced user customization options, improved performance, and a brand-new feature that will take your experience to the next level. Stay tuned for the big reveal!" },
                    { 2, 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 2, "Great question! User privacy and data security are our top priorities. We implement robust encryption protocols, conduct regular security audits, and adhere to strict privacy policies. Rest assured, your data is in safe hands!" },
                    { 3, 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 3, "We're working on creating exciting community events and challenges. Imagine interactive quizzes, themed discussions, and collaborative projects. Your feedback matters, so if you have any event ideas, feel free to share! Let's make this platform even more vibrant together." },
                    { 4, 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 4, "We use a combination of automated tools and human moderation to ensure content aligns with our guidelines. We're committed to fostering an inclusive and respectful space for everyone. Your reports and feedback play a crucial role in keeping our community healthy!" }
                });

            migrationBuilder.InsertData(
                table: "Comments",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "PostId", "Text", "UserId" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 3, "Pumped for my Sunday workout! Cardio or weights, what's your go-to fitness move?", 2 },
                    { 2, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 3, "Yoga mornings are my favorite! Any yogis here? Share your favorite pose.", 3 },
                    { 3, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 6, "Heard about a local community garden initiative that's making a huge impact. Love seeing positive change in action!", 4 },
                    { 4, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 6, "My mood instantly lifts when I read about acts of kindness. Share a heartwarming news story that made your day!", 5 },
                    { 5, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 9, "Usually all about pop, but diving into classical this week. Any recommendations for a newbie?", 2 },
                    { 6, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 9, "Jazz is my guilty pleasure! Drop your favorite jazz tune, and let's create a smooth playlist together.", 3 },
                    { 7, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 11, "Casablanca is an absolute classic! What's your favorite line from an old-school movie that still gives you chills?", 5 },
                    { 8, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 11, "Bringing back the nostalgia with The Breakfast Club! Which classic film takes you on a trip down memory lane?", 5 }
                });

            migrationBuilder.InsertData(
                table: "Likes",
                columns: new[] { "Id", "CreatedAt", "ModifiedAt", "PostId", "Type", "UserId" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 1, true, 2 },
                    { 2, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 2, true, 3 },
                    { 3, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 3, true, 5 },
                    { 4, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 4, false, 5 },
                    { 5, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 5, true, 3 },
                    { 6, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 6, false, 3 },
                    { 7, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 7, true, 4 },
                    { 8, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 8, true, 3 },
                    { 9, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 9, true, 2 },
                    { 10, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 10, false, 3 },
                    { 11, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 11, true, 4 },
                    { 12, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 12, true, 5 },
                    { 13, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 1, true, 3 },
                    { 14, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 2, false, 4 },
                    { 15, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 3, true, 4 },
                    { 16, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 4, true, 4 },
                    { 17, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 5, true, 2 },
                    { 18, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 6, false, 4 },
                    { 19, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 7, true, 5 },
                    { 20, new DateTime(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local), null, 8, true, 5 }
                });

            migrationBuilder.CreateIndex(
                name: "IX_Answers_AdminId",
                table: "Answers",
                column: "AdminId");

            migrationBuilder.CreateIndex(
                name: "IX_Answers_QuestionId",
                table: "Answers",
                column: "QuestionId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Comments_PostId",
                table: "Comments",
                column: "PostId");

            migrationBuilder.CreateIndex(
                name: "IX_Comments_UserId",
                table: "Comments",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Images_MessageId",
                table: "Images",
                column: "MessageId");

            migrationBuilder.CreateIndex(
                name: "IX_Images_PostId",
                table: "Images",
                column: "PostId");

            migrationBuilder.CreateIndex(
                name: "IX_Likes_PostId",
                table: "Likes",
                column: "PostId");

            migrationBuilder.CreateIndex(
                name: "IX_Likes_UserId_PostId",
                table: "Likes",
                columns: new[] { "UserId", "PostId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Messages_ConversationId",
                table: "Messages",
                column: "ConversationId");

            migrationBuilder.CreateIndex(
                name: "IX_Messages_UserId",
                table: "Messages",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Posts_GroupId",
                table: "Posts",
                column: "GroupId");

            migrationBuilder.CreateIndex(
                name: "IX_Posts_TagId",
                table: "Posts",
                column: "TagId");

            migrationBuilder.CreateIndex(
                name: "IX_Posts_UserId",
                table: "Posts",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Questions_UserId",
                table: "Questions",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Reports_ReportedId",
                table: "Reports",
                column: "ReportedId");

            migrationBuilder.CreateIndex(
                name: "IX_Reports_ReporterId",
                table: "Reports",
                column: "ReporterId");

            migrationBuilder.CreateIndex(
                name: "IX_Subscriptions_UserId",
                table: "Subscriptions",
                column: "UserId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_UserConversations_ConversationId",
                table: "UserConversations",
                column: "ConversationId");

            migrationBuilder.CreateIndex(
                name: "IX_UserConversations_UserId",
                table: "UserConversations",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Answers");

            migrationBuilder.DropTable(
                name: "Comments");

            migrationBuilder.DropTable(
                name: "Images");

            migrationBuilder.DropTable(
                name: "Likes");

            migrationBuilder.DropTable(
                name: "Reports");

            migrationBuilder.DropTable(
                name: "Subscriptions");

            migrationBuilder.DropTable(
                name: "UserConversations");

            migrationBuilder.DropTable(
                name: "Questions");

            migrationBuilder.DropTable(
                name: "Messages");

            migrationBuilder.DropTable(
                name: "Posts");

            migrationBuilder.DropTable(
                name: "Conversations");

            migrationBuilder.DropTable(
                name: "Groups");

            migrationBuilder.DropTable(
                name: "Tags");

            migrationBuilder.DropTable(
                name: "Users");
        }
    }
}
