using Microsoft.EntityFrameworkCore;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public partial class DatabaseContext
    {
        private readonly DateTime _dateTime = DateTime.Now.AddYears(-1);
        private readonly DateTime _dateTime2 = DateTime.Now.AddMonths(-6);
        private readonly DateTime _dateTime3 = DateTime.Now;


        static string imageString = "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";
        private readonly byte[] _image = Convert.FromBase64String(imageString);

        private void SeedData(ModelBuilder modelBuilder)
        {
            SeedUsers(modelBuilder);
            SeedGroups(modelBuilder);
            SeedTags(modelBuilder);
            SeedPosts(modelBuilder);
            SeedComments(modelBuilder);
            SeedLikes(modelBuilder);
            SeedQuestions(modelBuilder);
            SeedAnswers(modelBuilder);
            SeedConversations(modelBuilder);
            SeedMessages(modelBuilder);
            SeedUserConversations(modelBuilder);
            SeedSubscriptions(modelBuilder);
            SeedImages(modelBuilder);
        }

        private void SeedUsers(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>().HasData(
                new User
                {
                    Id = 1,
                    Email = "user@mail.com",
                    Username = "TestUser",
                    Role = Role.Administrator,
                    PasswordHash = "KnHtwSBaEBRQ4kirxu8qLLU+20BraHV95Aj4JJcTZyQ=", //Plain text: test
                    PasswordSalt = "0dUI00v6BWmtxp8JCAyw9w==",
                    BirthDate = _dateTime,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new User
                {
                    Id = 2,
                    Email = "user2@mail.com",
                    Username = "TestUser2",
                    Role = Role.User,
                    PasswordHash = "KnHtwSBaEBRQ4kirxu8qLLU+20BraHV95Aj4JJcTZyQ=", //Plain text: test
                    PasswordSalt = "0dUI00v6BWmtxp8JCAyw9w==",
                    BirthDate = _dateTime,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new User
                {
                    Id = 3,
                    Email = "user3@mail.com",
                    Username = "TestUser3",
                    Role = Role.User,
                    PasswordHash = "KnHtwSBaEBRQ4kirxu8qLLU+20BraHV95Aj4JJcTZyQ=", //Plain text: test
                    PasswordSalt = "0dUI00v6BWmtxp8JCAyw9w==",
                    BirthDate = _dateTime,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new User
                {
                    Id = 4,
                    Email = "user4@mail.com",
                    Username = "TestUser4",
                    Role = Role.User,
                    PasswordHash = "KnHtwSBaEBRQ4kirxu8qLLU+20BraHV95Aj4JJcTZyQ=", //Plain text: test
                    PasswordSalt = "0dUI00v6BWmtxp8JCAyw9w==",
                    BirthDate = _dateTime,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new User
                {
                    Id = 5,
                    Email = "user5@mail.com",
                    Username = "TestUser5",
                    Role = Role.User,
                    PasswordHash = "KnHtwSBaEBRQ4kirxu8qLLU+20BraHV95Aj4JJcTZyQ=", //Plain text: test
                    PasswordSalt = "0dUI00v6BWmtxp8JCAyw9w==",
                    BirthDate = _dateTime,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new User
                {
                    Id = 6,
                    Email = "user6@mail.com",
                    Username = "TestUser6",
                    Role = Role.User,
                    PasswordHash = "KnHtwSBaEBRQ4kirxu8qLLU+20BraHV95Aj4JJcTZyQ=", //Plain text: test
                    PasswordSalt = "0dUI00v6BWmtxp8JCAyw9w==",
                    BirthDate = _dateTime,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new User
                {
                    Id = 7,
                    Email = "user7@mail.com",
                    Username = "TestUser7",
                    Role = Role.Administrator,
                    PasswordHash = "KnHtwSBaEBRQ4kirxu8qLLU+20BraHV95Aj4JJcTZyQ=", //Plain text: test
                    PasswordSalt = "0dUI00v6BWmtxp8JCAyw9w==",
                    BirthDate = _dateTime,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                });
        }

        private void SeedGroups(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Group>().HasData(
                new Group
                {
                    Id = 1,
                    Name = "Sports",
                    Description = "Sports news and highlight from all major sports organizations",
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Group
                {
                    Id = 2,
                    Name = "News",
                    Description = "A place for major news from around the world",
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Group
                {
                    Id = 3,
                    Name = "Music",
                    Description = "The #1 community for music lovers",
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Group
                {
                    Id = 4,
                    Name = "Movies",
                    Description = "The goal of this group is to provide a place for discussion and news about films",
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Group
                {
                    Id = 5,
                    Name = "Jokes",
                    Description = "The internets largest humor depository",
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                });
        }

        private void SeedTags(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Tag>().HasData(
            new Tag
            {
                Id = 1,
                Name = "Long",
                CreatedAt = _dateTime,
                ModifiedAt = null
            },
            new Tag
            {
                Id = 2,
                Name = "Short",
                CreatedAt = _dateTime,
                ModifiedAt = null
            },
            new Tag
            {
                Id = 3,
                Name = "Discussion",
                CreatedAt = _dateTime,
                ModifiedAt = null
            },
            new Tag
            {
                Id = 4,
                Name = "Media",
                CreatedAt = _dateTime,
                ModifiedAt = null
            },
            new Tag
            {
                Id = 5,
                Name = "Serious",
                CreatedAt = _dateTime,
                ModifiedAt = null
            },
            new Tag
            {
                Id = 6,
                Name = "Interesting",
                CreatedAt = _dateTime,
                ModifiedAt = null
            });
        }

        private void SeedPosts(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Post>().HasData(
                new Post
                {
                    Id = 1,
                    Title = "Game On!",
                    Text = "Whether it's a slam dunk, a goal celebration, or a touchdown dance, the adrenaline rush of sports is unmatched! What's your favorite sport, and which team has your heart? Drop your cheers in the comments below!",
                    IsAdvert = true,
                    UserId = 2,
                    GroupId = 1,
                    TagId = null,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 2,
                    Title = "Sunday Showdown!",
                    Text = "Sundays are made for epic sports battles! Which team are you cheering for today, and who's your MVP? Let the banter begin as we countdown to the final whistle. Game on, sports enthusiasts!",
                    UserId = 2,
                    GroupId = 1,
                    TagId = null,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 3,
                    Title = "Fitness Fanatics Unite!",
                    Text = "Whether it's hitting the gym, pounding the pavement, or mastering a new yoga pose, let's celebrate the fitness journey together! Share your favorite workout routine or fitness tips that keep you motivated. Let's inspire each other to break a sweat!",
                    UserId = 3,
                    GroupId = 1,
                    TagId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 4,
                    Title = "Headlines Unveiled: Stay Informed!",
                    Text = "From global events to local buzz, staying updated is key! What news story caught your attention today? Share your thoughts and let's discuss the stories shaping our world. Knowledge is power!",
                    UserId = 3,
                    GroupId = 2,
                    TagId = null,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 5,
                    Title = "Trending Topics Alert!",
                    Text = "From groundbreaking discoveries to viral trends, what's been catching your eye in the news lately? Let's dive deep into the headlines and share our thoughts on the stories shaping our world. What's your take?",
                    UserId = 4,
                    GroupId = 2,
                    TagId = null,
                    CreatedAt = _dateTime,
                    ModifiedAt = null,
                },
                new Post
                {
                    Id = 6,
                    Title = "Positive News Vibes Only!",
                    Text = "In a world full of headlines, let's focus on the positive stories that warm our hearts. Share a recent news piece that made you smile or inspired you. Together, let's spread positivity and celebrate the good vibes!",
                    UserId = 4,
                    GroupId = 2,
                    TagId = null,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 7,
                    Title = "Melody Magic",
                    Text = "Music is the soundtrack of our lives, and every beat tells a story. What song is playing on repeat for you right now? Share your current music obsession and let's create a playlist together!",
                    UserId = 5,
                    GroupId = 3,
                    TagId = null,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 8,
                    Title = "Musical Memories Monday!",
                    Text = "Mondays are for reminiscing! Share a musical memory that takes you back in time. Whether it's a concert, a road trip playlist, or a special dance moment, let's rewind the clock and relive the magic together.",
                    IsAdvert = true,
                    UserId = 3,
                    GroupId = 3,
                    TagId = 3,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 9,
                    Title = "Genre Swap Challenge!",
                    Text = "Let's shake things up! Challenge accepted: switch to a music genre you rarely explore. Share a song or artist from the new genre you're diving into, and let's see who discovers their next favorite tune!",
                    UserId = 4,
                    GroupId = 3,
                    TagId = null,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 10,
                    Title = "Movie Buff Vibes",
                    Text = "Whether it's a blockbuster hit or a hidden gem, what movie stole the show for you recently? Share your top picks, and let's swap recommendations for the ultimate movie night!",
                    UserId = 2,
                    GroupId = 4,
                    TagId = null,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 11,
                    Title = "Cinematic Classics Countdown!",
                    Text = "Dive into the archives with me! What classic movie holds a special place in your heart? Share your all-time favorite cinematic masterpiece, and let's reminisce about the golden era of film together.",
                    IsAdvert = true,
                    UserId = 3,
                    GroupId = 4,
                    TagId = 3,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 12,
                    Title = "Movie Marathon Madness!",
                    Text = "Planning a movie marathon this weekend? Share your must-watch movie list, and let's curate the ultimate movie night lineup! From comedies to dramas, let's make it an unforgettable cinematic experience.",
                    UserId = 5,
                    GroupId = 4,
                    TagId = null,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 13,
                    Title = "Laughter is the Best Medicine!",
                    Text = "Life's too short to be serious all the time! Let's brighten up our day with some laughter. Share your favorite joke in the comments below and spread the joy! Remember, a good chuckle can turn any day around. Let's keep the laughter rolling!",
                    UserId = 2,
                    GroupId = 5,
                    TagId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 14,
                    Title = "Funny Friday Vibes!",
                    Text = "TGIF, folks! Let's kick off the weekend with a dose of humor. Share your funniest memes, gifs, or jokes that never fail to make you crack a smile. Laughter is contagious, so let's spread the joy and start the weekend on a hilarious note!",
                    UserId = 3,
                    GroupId = 5,
                    TagId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 15,
                    Title = "Caption This Challenge!",
                    Text = "Calling all witty minds! It's time for a caption challenge. Check out the hilarious photo below and let your creativity run wild. Reply with your funniest captions, and let's see who can come up with the most side-splitting one-liner!",
                    UserId = 4,
                    GroupId = 5,
                    TagId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 16,
                    Title = "Game Day Ready!",
                    Text = "Let's do this!",
                    IsAdvert = true,
                    UserId = 2,
                    GroupId = 1,
                    TagId = null,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 17,
                    Title = "Sports Heroes",
                    Text = "Who's yours?",
                    UserId = 3,
                    GroupId = 1,
                    TagId = null,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 18,
                    Title = "Victory Cheers!",
                    Text = "Celebrating another win!",
                    UserId = 4,
                    GroupId = 1,
                    TagId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 19,
                    Title = "Keep Pushing!",
                    Text = "Practice pays off.",
                    UserId = 5,
                    GroupId = 1,
                    TagId = null,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 20,
                    Title = "Thrill of Competition",
                    Text = "Nothing beats it.",
                    UserId = 6,
                    GroupId = 1,
                    TagId = null,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 21,
                    Title = "Musical Escape",
                    Text = "Tune in and drift away.",
                    UserId = 2,
                    GroupId = 3,
                    TagId = null,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 22,
                    Title = "Soulful Lyrics",
                    Text = "Poetry in motion.",
                    UserId = 3,
                    GroupId = 3,
                    TagId = null,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 23,
                    Title = "Volume Up, World Off",
                    Text = "Let the music take over.",
                    IsAdvert = true,
                    UserId = 4,
                    GroupId = 3,
                    TagId = 2,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 24,
                    Title = "Favorite Playlist Vibes",
                    Text = "Can't get enough.",
                    UserId = 5,
                    GroupId = 3,
                    TagId = null,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 25,
                    Title = "Rhythm & Harmony",
                    Text = "Music speaks louder.",
                    UserId = 6,
                    GroupId = 3,
                    TagId = null,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 26,
                    Title = "Movie Night Essentials",
                    Text = "Popcorn and chill.",
                    IsAdvert = true,
                    UserId = 2,
                    GroupId = 4,
                    TagId = 3,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 27,
                    Title = "Lights, Camera, Genre?",
                    Text = "What's your pick?",
                    UserId = 3,
                    GroupId = 4,
                    TagId = null,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 28,
                    Title = "Plot Twist!",
                    Text = "Mind blown.",
                    UserId = 4,
                    GroupId = 4,
                    TagId = 2,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 29,
                    Title = "Movie Marathon Time",
                    Text = "Cozy up and binge.",
                    UserId = 5,
                    GroupId = 4,
                    TagId = null,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 30,
                    Title = "Cinematic Marvels",
                    Text = "Captivating moments.",
                    UserId = 6,
                    GroupId = 4,
                    TagId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 31,
                    Title = "Staying Informed",
                    Text = "Eyes on the headlines.",
                    UserId = 2,
                    GroupId = 2,
                    TagId = null,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 32,
                    Title = "Knowledge is Key",
                    Text = "Stay ahead of the curve.",
                    UserId = 3,
                    GroupId = 2,
                    TagId = null,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 33,
                    Title = "Breaking News Alert",
                    Text = "Stay tuned.",
                    IsAdvert = true,
                    UserId = 4,
                    GroupId = 2,
                    TagId = null,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 34,
                    Title = "Truth Seekers Unite",
                    Text = "Fact-checking matters.",
                    UserId = 5,
                    GroupId = 2,
                    TagId = null,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 35,
                    Title = "Diverse Perspectives",
                    Text = "Broaden your horizons.",
                    UserId = 6,
                    GroupId = 2,
                    TagId = null,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 36,
                    Title = "Spread the Laughs",
                    Text = "Got a joke? Share away!",
                    UserId = 2,
                    GroupId = 5,
                    TagId = null,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 37,
                    Title = "Monday Funnies",
                    Text = " Let's lighten up.",
                    UserId = 3,
                    GroupId = 5,
                    TagId = null,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 38,
                    Title = "Knock-Knock!",
                    Text = "Who's there?",
                    UserId = 4,
                    GroupId = 5,
                    TagId = 2,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 39,
                    Title = "Laughter is Medicine",
                    Text = "Healing through humor.",
                    UserId = 5,
                    GroupId = 5,
                    TagId = null,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 40,
                    Title = "Dad Jokes Galore",
                    Text = "Brace yourselves.",
                    UserId = 6,
                    GroupId = 5,
                    TagId = null,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                }
                );
        }

        private void SeedComments(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Comment>().HasData(
                new Comment
                {
                    Id = 1,
                    Text = "Pumped for my Sunday workout! Cardio or weights, what's your go-to fitness move?",
                    UserId = 2,
                    PostId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 2,
                    Text = "Yoga mornings are my favorite! Any yogis here? Share your favorite pose.",
                    UserId = 3,
                    PostId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 3,
                    Text = "Heard about a local community garden initiative that's making a huge impact. Love seeing positive change in action!",
                    UserId = 4,
                    PostId = 6,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 4,
                    Text = "My mood instantly lifts when I read about acts of kindness. Share a heartwarming news story that made your day!",
                    UserId = 5,
                    PostId = 6,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 5,
                    Text = "Usually all about pop, but diving into classical this week. Any recommendations for a newbie?",
                    UserId = 2,
                    PostId = 9,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 6,
                    Text = "Jazz is my guilty pleasure! Drop your favorite jazz tune, and let's create a smooth playlist together.",
                    UserId = 3,
                    PostId = 9,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 7,
                    Text = "Casablanca is an absolute classic! What's your favorite line from an old-school movie that still gives you chills?",
                    UserId = 5,
                    PostId = 11,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 8,
                    Text = "Bringing back the nostalgia with The Breakfast Club! Which classic film takes you on a trip down memory lane?",
                    UserId = 5,
                    PostId = 11,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 9,
                    Text = "Let's go, team!",
                    UserId = 3,
                    PostId = 16,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 10,
                    Text = "That winning feeling never gets old!",
                    UserId = 2,
                    PostId = 18,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 11,
                    Text = "Music is my happy place!",
                    UserId = 4,
                    PostId = 21,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 12,
                    Text = "Getting lost in the melody.",
                    UserId = 5,
                    PostId = 23,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 13,
                    Text = "Popcorn ready, movie queued!",
                    UserId = 6,
                    PostId = 26,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 14,
                    Text = "Didn't see that coming!",
                    UserId = 3,
                    PostId = 28,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 15,
                    Text = "Keeping up with the headlines.",
                    UserId = 5,
                    PostId = 31,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 16,
                    Text = "Excited to see what's happening!",
                    UserId = 6,
                    PostId = 33,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 17,
                    Text = "Ready for some good laughs!",
                    UserId = 5,
                    PostId = 36,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 18,
                    Text = "Bring on the jokes, need a good laugh!",
                    UserId = 4,
                    PostId = 39,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                }
                );
        }

        private void SeedLikes(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Like>().HasData(
                new Like
                {
                    Id = 1,
                    Type = true,
                    PostId = 1,
                    UserId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 2,
                    Type = true,
                    PostId = 2,
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 3,
                    Type = true,
                    PostId = 3,
                    UserId = 5,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 4,
                    Type = false,
                    PostId = 4,
                    UserId = 5,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 5,
                    Type = true,
                    PostId = 5,
                    UserId = 3,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 6,
                    Type = false,
                    PostId = 6,
                    UserId = 3,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 7,
                    Type = true,
                    PostId = 7,
                    UserId = 4,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 8,
                    Type = true,
                    PostId = 8,
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 9,
                    Type = true,
                    PostId = 9,
                    UserId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 10,
                    Type = false,
                    PostId = 10,
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 11,
                    Type = true,
                    PostId = 11,
                    UserId = 4,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 12,
                    Type = true,
                    PostId = 12,
                    UserId = 5,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 13,
                    Type = true,
                    PostId = 1,
                    UserId = 3,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 14,
                    Type = false,
                    PostId = 2,
                    UserId = 4,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 15,
                    Type = true,
                    PostId = 3,
                    UserId = 4,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 16,
                    Type = true,
                    PostId = 4,
                    UserId = 4,
                    CreatedAt = _dateTime2,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 17,
                    Type = true,
                    PostId = 5,
                    UserId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 18,
                    Type = false,
                    PostId = 6,
                    UserId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 19,
                    Type = true,
                    PostId = 7,
                    UserId = 5,
                    CreatedAt = _dateTime3,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 20,
                    Type = true,
                    PostId = 8,
                    UserId = 5,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 21,
                    Type = true,
                    PostId = 13,
                    UserId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 22,
                    Type = true,
                    PostId = 13,
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 23,
                    Type = true,
                    PostId = 15,
                    UserId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 24,
                    Type = false,
                    PostId = 17,
                    UserId = 6,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 25,
                    Type = true,
                    PostId = 17,
                    UserId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 26,
                    Type = true,
                    PostId = 19,
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 27,
                    Type = true,
                    PostId = 19,
                    UserId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 28,
                    Type = true,
                    PostId = 21,
                    UserId = 5,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 29,
                    Type = false,
                    PostId = 21,
                    UserId = 6,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 30,
                    Type = false,
                    PostId = 23,
                    UserId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 31,
                    Type = true,
                    PostId = 23,
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 32,
                    Type = true,
                    PostId = 25,
                    UserId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 33,
                    Type = true,
                    PostId = 25,
                    UserId = 5,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 34,
                    Type = true,
                    PostId = 27,
                    UserId = 6,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 35,
                    Type = false,
                    PostId = 27,
                    UserId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 36,
                    Type = false,
                    PostId = 29,
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 37,
                    Type = true,
                    PostId = 29,
                    UserId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 38,
                    Type = true,
                    PostId = 31,
                    UserId = 5,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 39,
                    Type = true,
                    PostId = 31,
                    UserId = 6,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 40,
                    Type = true,
                    PostId = 33,
                    UserId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 41,
                    Type = false,
                    PostId = 33,
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 42,
                    Type = false,
                    PostId = 35,
                    UserId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 43,
                    Type = true,
                    PostId = 35,
                    UserId = 5,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 44,
                    Type = true,
                    PostId = 37,
                    UserId = 6,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 45,
                    Type = true,
                    PostId = 37,
                    UserId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 46,
                    Type = true,
                    PostId = 39,
                    UserId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 47,
                    Type = false,
                    PostId = 39,
                    UserId = 5,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 48,
                    Type = false,
                    PostId = 15,
                    UserId = 5,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                }
                );
        }

        private void SeedQuestions(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Question>().HasData(
                new Question
                {
                    Id=1,
                    Text= "I'm curious about the future updates! Can you give us a sneak peek into any upcoming features or improvements?",
                    UserId=2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Question
                {
                    Id = 2,
                    Text = "How do you ensure the safety and privacy of user data on the platform?",
                    UserId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Question
                {
                    Id = 3,
                    Text = "Are there any plans for community events or challenges on the platform? It would be awesome to engage with other users in a fun way!",
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Question
                {
                    Id = 4,
                    Text = "How does content moderation work to ensure a positive and respectful environment?",
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Question
                {
                    Id = 5,
                    Text = "I'm curious about the technology behind the scenes. What kind of AI models power the platform, and how do you ensure they're unbiased?",
                    UserId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Question
                {
                    Id = 6,
                    Text = "Are there plans to expand the app to support different languages and cultures?",
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Question
                {
                    Id = 7,
                    Text = "How can users contribute to the development of the platform? Any plans for a user feedback program?",
                    UserId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Question
                {
                    Id = 8,
                    Text = "In case of technical issues or bugs, what's the best way for users to report them and get assistance?",
                    UserId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                }
                );
        }

        private void SeedAnswers(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Answer>().HasData(
                new Answer
                {
                    Id = 1,
                    Text = "Absolutely! We're thrilled about the upcoming updates. Get ready for enhanced user customization options, improved performance, and a brand-new feature that will take your experience to the next level. Stay tuned for the big reveal!",
                    AdminId = 1,
                    QuestionId = 1,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Answer
                {
                    Id = 2,
                    Text = "Great question! User privacy and data security are our top priorities. We implement robust encryption protocols, conduct regular security audits, and adhere to strict privacy policies. Rest assured, your data is in safe hands!",
                    AdminId = 1,
                    QuestionId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Answer
                {
                    Id = 3,
                    Text = "We're working on creating exciting community events and challenges. Imagine interactive quizzes, themed discussions, and collaborative projects. Your feedback matters, so if you have any event ideas, feel free to share! Let's make this platform even more vibrant together.",
                    AdminId = 1,
                    QuestionId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Answer
                {
                    Id = 4,
                    Text = "We use a combination of automated tools and human moderation to ensure content aligns with our guidelines. We're committed to fostering an inclusive and respectful space for everyone. Your reports and feedback play a crucial role in keeping our community healthy!",
                    AdminId = 1,
                    QuestionId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                }
                );
        }

        private void SeedConversations(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Conversation>().HasData(
                new Conversation
                {
                    Id = 1,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Conversation
                {
                    Id = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Conversation
                {
                    Id = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Conversation
                {
                    Id = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                }
                );
        }

        private void SeedMessages(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Message>().HasData(
                new Message
                {
                    Id = 1,
                    Text = "Just finished a killer workout. What's up with you?",
                    UserId = 2,
                    ConversationId = 1,
                    CreatedAt = new(2023, 2, 1, 0, 1, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 2,
                    Text = "I'm just chilling and catching up on some reading. Any exciting plans for the weekend?",
                    UserId = 3,
                    ConversationId = 1,
                    CreatedAt = new(2023, 2, 1, 0, 2, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 3,
                    Text = "Thinking of hitting the trails for a hike. Nature vibes, you know? What about you?",
                    UserId = 2,
                    ConversationId = 1,
                    CreatedAt = new(2023, 2, 1, 0, 3, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 4,
                    Text = "That sounds awesome! I might check out a new coffee shop downtown. Any book recommendations?",
                    UserId = 3,
                    ConversationId = 1,
                    CreatedAt = new(2023, 2, 1, 0, 4, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 5,
                    Text = "Absolutely! \"The Night Circus\" is a magical read. What kind of books are you into lately?",
                    UserId = 2,
                    ConversationId = 1,
                    CreatedAt = new(2023, 2, 1, 0, 5, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 6,
                    Text = "I'm on a sci-fi kick lately. Just finished \"Dune\" — epic world-building! Got any sci-fi gems in mind?",
                    UserId = 3,
                    ConversationId = 1,
                    CreatedAt = new(2023, 2, 1, 0, 6, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 7,
                    Text = "Nice choice! \"Neuromancer\" is a classic cyberpunk adventure. What's your favorite sci-fi element?",
                    UserId = 2,
                    ConversationId = 1,
                    CreatedAt = new(2023, 2, 1, 0, 6, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 8,
                    Text = "Definitely the exploration of AI and its impact on society. Love those thought-provoking themes. What about you?",
                    UserId = 3,
                    ConversationId = 1,
                    CreatedAt = new(2023, 2, 1, 0, 7, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 9,
                    Text = "Same here! The ethical dilemmas in AI stories always get me thinking. Changing topics, any movie plans for the night?",
                    UserId = 2,
                    ConversationId = 1,
                    CreatedAt = new(2023, 2, 1, 0, 8, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 10,
                    Text = "Just downloaded a new indie film. \"Eternal Sunshine of the Spotless Mind.\" Heard it's a mind-bender. Have you seen it?",
                    UserId = 3,
                    ConversationId = 1,
                    CreatedAt = new(2023, 2, 1, 0, 9, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 11,
                    Text = "Absolutely love that one! Jim Carrey in a different light, you know?",
                    UserId = 2,
                    ConversationId = 1,
                    CreatedAt = new(2023, 2, 1, 0, 10, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 12,
                    Text = "Enjoy the journey! Let me know how you find it.",
                    UserId = 2,
                    ConversationId = 1,
                    CreatedAt = new(2023, 2, 1, 0, 11, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 13,
                    Text = "Thanks. Enjoy your hike and have a fantastic weekend!",
                    UserId = 3,
                    ConversationId = 1,
                    CreatedAt = new(2023, 2, 1, 0, 12, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 14,
                    Text = "Just got tickets to that new comedy show downtown. Interested in joining?",
                    UserId = 4,
                    ConversationId = 2,
                    CreatedAt = new(2023, 2, 1, 0, 1, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 15,
                    Text = "Sounds fun! Count me in. When's the show?",
                    UserId = 5,
                    ConversationId = 2,
                    CreatedAt = new(2023, 2, 1, 0, 2, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 16,
                    Text = "It's this Saturday at 8 PM. Perfect way to kick off the weekend!",
                    UserId = 4,
                    ConversationId = 2,
                    CreatedAt = new(2023, 2, 1, 0, 3, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 17,
                    Text = "Awesome! Looking forward to it. Anything else happening this week?",
                    UserId = 5,
                    ConversationId = 2,
                    CreatedAt = new(2023, 2, 1, 0, 4, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 18,
                    Text = "Not much, just work and the usual. Any movie recommendations for a cozy night in?",
                    UserId = 4,
                    ConversationId = 2,
                    CreatedAt = new(2023, 2, 1, 0, 5, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 19,
                    Text = "How about \"The Grand Budapest Hotel\"? Quirky and entertaining!",
                    UserId = 5,
                    ConversationId = 2,
                    CreatedAt = new(2023, 2, 1, 0, 6, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 20,
                    Text = "Great pick! I'll check it out. See you Saturday!",
                    UserId = 4,
                    ConversationId = 2,
                    CreatedAt = new(2023, 2, 1, 0, 7, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 21,
                    Text = "Can't wait! See you then!",
                    UserId = 5,
                    ConversationId = 2,
                    CreatedAt = new(2023, 2, 1, 0, 8, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 22,
                    Text = "Hello?",
                    UserId = 2,
                    ConversationId = 3,
                    CreatedAt = new(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 23,
                    Text = "Hi.",
                    UserId = 4,
                    ConversationId = 3,
                    CreatedAt = new(2023, 2, 1, 0, 1, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 24,
                    Text = "Hello?",
                    UserId = 3,
                    ConversationId = 4,
                    CreatedAt = new(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                },
                new Message
                {
                    Id = 25,
                    Text = "Hi!",
                    UserId = 5,
                    ConversationId = 4,
                    CreatedAt = new(2023, 2, 1, 0, 1, 0, 0, DateTimeKind.Local),
                    ModifiedAt = null
                }
                );
        }

        private void SeedUserConversations(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UserConversation>().HasData(
                new UserConversation
                {
                    Id = 1,
                    UserId = 2,
                    ConversationId = 1,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new UserConversation
                {
                    Id = 2,
                    UserId = 3,
                    ConversationId = 1,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new UserConversation
                {
                    Id = 3,
                    UserId = 4,
                    ConversationId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new UserConversation
                {
                    Id = 4,
                    UserId = 5,
                    ConversationId = 2,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new UserConversation
                {
                    Id = 5,
                    UserId = 2,
                    ConversationId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new UserConversation
                {
                    Id = 6,
                    UserId = 4,
                    ConversationId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new UserConversation
                {
                    Id = 7,
                    UserId = 3,
                    ConversationId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new UserConversation
                {
                    Id = 8,
                    UserId = 5,
                    ConversationId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                }
                );
        }

        private void SeedSubscriptions(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Subscription>().HasData(
                new Subscription
                {
                    Id = 1,
                    UserId = 4,
                    Active = true,
                    ExpirationDate = DateTime.Now.AddMonths(3),
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Subscription
                {
                    Id = 2,
                    UserId = 6,
                    Active = true,
                    ExpirationDate = DateTime.Now.AddMonths(3),
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                }
                );
        }

        private void SeedImages(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Image>().HasData(
                new Image
                {
                    Id= 1,
                    Data = _image,
                    ContentType = "Image",
                    PostId = 15,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Image
                {
                    Id = 2,
                    Data = _image,
                    ContentType = "Image",
                    PostId = 10,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Image
                {
                    Id = 3,
                    Data = _image,
                    ContentType = "Image",
                    MessageId = 5,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Image
                {
                    Id = 4,
                    Data = _image,
                    ContentType = "Image",
                    PostId = 20,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Image
                {
                    Id = 5,
                    Data = _image,
                    ContentType = "Image",
                    PostId = 31,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                }
                );
        }
    }
}
