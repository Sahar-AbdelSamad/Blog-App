# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')

# Posts
first_post = Post.create(author_id: first_user.id, title: 'Hello', text: 'This is my first post')
second_post = Post.create(author_id: first_user.id, title: 'Hi', text: 'This is my second post')
third_post = Post.create(author_id: first_user.id, title: 'Hi there', text: 'This is my third post')
fourth_post = Post.create(author_id: first_user.id, title: 'Hello!', text: 'This is my fourth post')

# Comments
Comment.create(post_id: first_post.id, author_id: first_user.id, text: 'Hi Tom!')
Comment.create(post_id: first_post.id, author_id: first_user.id, text: 'Hi Tom!')
Comment.create(post_id: first_post.id, author_id: first_user.id, text: 'Hi!')
Comment.create(post_id: first_post.id, author_id: first_user.id, text: 'Hello there')
Comment.create(post_id: first_post.id, author_id: first_user.id, text: 'Hello there!')
Comment.create(post_id: first_post.id, author_id: first_user.id, text: 'Hello')
