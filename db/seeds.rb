# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Category.destroy_all

@user = User.new(email: 'admin@user.com', password: '123456', password_confirmation: '123456', role: 1)
@user.save!

@category = Category.create([
                              { name: 'Musician' },
                              { name: 'Dancer' },
                              { name: 'Painter' },
                              { name: 'Photographer' },
                              { name: 'Writer' }
                            ])

@artist1 = Artist.new(name: 'Jon snow',
                      dob: '2021-01-01',
                      location: "Night's watch",
                      work: 'Painter',
                      email: 'Jonsnow@gmail.com',
                      category_id: 3,
                      links: 'https://www.youtube.com/watch?v=DP_NqOOeoao')
@artist1.image.attach(io: File.open('app/assets/images/a2.jpg'), filename: 'a2.jpg')
@artist1.pictures.attach(io: File.open('app/assets/images/p1.jpg'), filename: 'p1.jpg')
@artist1.pictures.attach(io: File.open('app/assets/images/p2.jpg'), filename: 'p2.jpg')
@artist1.pictures.attach(io: File.open('app/assets/images/p3.jpg'), filename: 'p3.jpg')
@artist1.pictures.attach(io: File.open('app/assets/images/p4.jpg'), filename: 'p4.jpg')
@artist1.pictures.attach(io: File.open('app/assets/images/p5.jpg'), filename: 'p5.jpg')
@artist1.pictures.attach(io: File.open('app/assets/images/p6.jpg'), filename: 'p6.jpg')
@artist1.pictures.attach(io: File.open('app/assets/images/p8.jpg'), filename: 'p8.jpg')
@artist1.pictures.attach(io: File.open('app/assets/images/p9.jpg'), filename: 'p9.jpg')

@artist1.save

@artist2 = Artist.new(name: 'Arya Stark',
                      dob: '2019-01-06',
                      location: 'Winterfell',
                      work: 'Dancer',
                      email: 'aryastark@gmail.com',
                      category_id: 2,
                      links: 'https://www.youtube.com/watch?v=vCI2kmFJD_w')
@artist2.image.attach(io: File.open('app/assets/images/a1.jpg'), filename: 'a1.jpg')
@artist2.pictures.attach(io: File.open('app/assets/images/d1.jpg'), filename: 'd1.jpg')
@artist2.pictures.attach(io: File.open('app/assets/images/d2.jpg'), filename: 'd2.jpg')
@artist2.pictures.attach(io: File.open('app/assets/images/d3.jpg'), filename: 'd3.jpg')
@artist2.pictures.attach(io: File.open('app/assets/images/d6.jpg'), filename: 'd6.jpg')
@artist2.pictures.attach(io: File.open('app/assets/images/d4.jpg'), filename: 'd4.jpg')
@artist2.pictures.attach(io: File.open('app/assets/images/d5.jpg'), filename: 'd5.jpg')
@artist2.pictures.attach(io: File.open('app/assets/images/d7.jpg'), filename: 'd7.jpg')
@artist2.pictures.attach(io: File.open('app/assets/images/d8.jpg'), filename: 'd8.jpg')

@artist2.save

@artist3 = Artist.new(name: 'Tyrion Lannister',
                      dob: '2015-01-06',
                      location: 'Casterly Rock',
                      work: 'Wildlife Photographer',
                      email: 'tyrionlannister@gmail.com',
                      category_id: 4,
                      links: 'https://www.youtube.com/watch?v=yxatrXPTd1k')
@artist3.image.attach(io: File.open('app/assets/images/a3.jpg'), filename: 'a3.jpg')
@artist3.pictures.attach(io: File.open('app/assets/images/c1.jpg'), filename: 'c1.jpg')
@artist3.pictures.attach(io: File.open('app/assets/images/c2.jpg'), filename: 'c2.jpg')
@artist3.pictures.attach(io: File.open('app/assets/images/c3.jpg'), filename: 'c3.jpg')
@artist3.pictures.attach(io: File.open('app/assets/images/c6.jpg'), filename: 'c6.jpg')
@artist3.pictures.attach(io: File.open('app/assets/images/c4.jpg'), filename: 'c4.jpg')
@artist3.pictures.attach(io: File.open('app/assets/images/c5.jpg'), filename: 'c5.jpg')
@artist3.pictures.attach(io: File.open('app/assets/images/c7.jpg'), filename: 'c7.jpg')
@artist3.pictures.attach(io: File.open('app/assets/images/c8.jpg'), filename: 'c8.jpg')

@artist3.save
