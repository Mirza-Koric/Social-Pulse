using Microsoft.EntityFrameworkCore;
using SocialPulse.Core;

namespace SocialPulse.Infrastructure
{
    public partial class DatabaseContext
    {
        private readonly DateTime _dateTime = new(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local);

        private void SeedData(ModelBuilder modelBuilder)
        {
            SeedUsers(modelBuilder);
            SeedGroups(modelBuilder);
            SeedTags(modelBuilder);
            SeedPosts(modelBuilder);
            SeedComments(modelBuilder);
            SeedLikes(modelBuilder);
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
                    CreatedAt = _dateTime,
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
                    CreatedAt = _dateTime,
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
                    CreatedAt = _dateTime,
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
                    ModifiedAt = null
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
                    Text = "Music is the soundtrack of our lives, and every beat tells a story. What song is playing on repeat for you right now? Share your current music obsession and let's create a playlist together! ",
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
                    UserId = 3,
                    GroupId = 3,
                    TagId = 3,
                    CreatedAt = _dateTime,
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
                    CreatedAt = _dateTime,
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
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Post
                {
                    Id = 11,
                    Title = "Cinematic Classics Countdown!",
                    Text = "Dive into the archives with me! What classic movie holds a special place in your heart? Share your all-time favorite cinematic masterpiece, and let's reminisce about the golden era of film together.",
                    UserId = 3,
                    GroupId = 4,
                    TagId = 3,
                    CreatedAt = _dateTime,
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
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                });
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
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 5,
                    Text = "Usually all about pop, but diving into classical this week. Any recommendations for a newbie?",
                    UserId = 2,
                    PostId = 9,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 6,
                    Text = "Jazz is my guilty pleasure! Drop your favorite jazz tune, and let's create a smooth playlist together.",
                    UserId = 3,
                    PostId = 9,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 7,
                    Text = "Casablanca is an absolute classic! What's your favorite line from an old-school movie that still gives you chills?",
                    UserId = 5,
                    PostId = 11,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Comment
                {
                    Id = 8,
                    Text = "Bringing back the nostalgia with The Breakfast Club! Which classic film takes you on a trip down memory lane?",
                    UserId = 5,
                    PostId = 11,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                });
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
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 4,
                    Type = false,
                    PostId = 4,
                    UserId = 5,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 5,
                    Type = true,
                    PostId = 5,
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 6,
                    Type = false,
                    PostId = 6,
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 7,
                    Type = true,
                    PostId = 7,
                    UserId = 4,
                    CreatedAt = _dateTime,
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
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 12,
                    Type = true,
                    PostId = 12,
                    UserId = 5,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 13,
                    Type = true,
                    PostId = 1,
                    UserId = 3,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 14,
                    Type = false,
                    PostId = 2,
                    UserId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 15,
                    Type = true,
                    PostId = 3,
                    UserId = 4,
                    CreatedAt = _dateTime,
                    ModifiedAt = null
                },
                new Like
                {
                    Id = 16,
                    Type = true,
                    PostId = 4,
                    UserId = 4,
                    CreatedAt = _dateTime,
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
                    CreatedAt = _dateTime,
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
                });
        }

    }
}
