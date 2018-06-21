require 'pry'
class MusicLibraryController
  @@song_list = []

  def initialize(file_path = "./db/mp3s")
    new_music = MusicImporter.new(file_path)
    new_music.import
    @song_list = []
  end

  def call
    puts "Welcome to your music library!"
    answer = ""
    options = ["list songs" , "list genres" , "list artist" , "list genre" , "play song" , "exit"]

    while !options.include?(answer) do
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      answer = gets
    end



    self.list_songs if answer == "list songs"
    self.list_artists if answer == "list artists"
  end

  def list_artists
    artist_list = Artist.all.sort_by! {|obj| obj.name}
    counter = 1
    artist_list.each do |artist_name|
      puts "#{counter}. #{artist_name.name}"
      counter += 1
    end
  end

  def list_genres
    genre_list = Genre.all.sort_by! {|obj| obj.name}
    counter = 1
    genre_list.each do |genre_name|
      puts "#{counter}. #{genre_name.name}"
      counter += 1
    end
  end

  def update_song_list
    Song.all.each do |song_object|
      if !@@song_list.include?(song_object)
        @@song_list << song_object
        @song_list << song_object
      end
    end
  end

  def list_songs
    #song_list = []
    self.update_song_list
    #sort songs alphabetically
    @song_list.sort_by! {|obj| obj.name}
    #puts each song with a number in front of it
    counter = 1
    #binding.pry
    @song_list.each do |song|
      puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      counter += 1
    end

  end

end
