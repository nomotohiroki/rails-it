require 'itunes/library'

class Tasks::LoadToDbTask
  def self.execute
    users = User.find(:all, :conditions => {:complete => false})
    for user in users
      lib = ITunes::Library.load(user.library_path)
      for libtrack in lib.tracks
        if libtrack.video? || libtrack.movie? || libtrack.podcast? || libtrack['Disabled'] || libtrack.artist == nil || libtrack.name == nil || libtrack['Total Time']  == nil
          next
        end

        albumArtistName = nil
        if libtrack['Compilation']
          albumArtistName = 'V.A.'
        elsif libtrack['Album Artist'] != nil
          albumArtistName = libtrack['Album Artist']
        else
          albumArtistName = libtrack.artist
        end

        doNext = true
        artist = Artist.find_by_name(albumArtistName)
        if artist == nil
          artist = Artist.new
          artist.name = albumArtistName
          artist.save
          doNext = false
        end

        album = nil
        if doNext
          album = Album.find_by_artist_id_and_name(artist.id, libtrack.album)
        end
        if album == nil && libtrack.album != nil
          album = Album.new
          album.name = libtrack.album
          album.track_count = libtrack['Track Count']
          album.artist_id = artist.id
          album.save
          doNext = false
        end

        track = nil
        if doNext
          track = Track.find_by_artist_id_and_name(artist.id, libtrack.name)
        end
        if track == nil
          track = Track.new
          track.name = libtrack.name
          track.artist_id = artist.id
          if album != nil
            track.album_id = album.id
          end
          track.track_artist = libtrack.artist
          track.track_no = libtrack.number
          track.total_time = libtrack.total_time
          track.save
        end
        userTrack = UserTrack.new
        userTrack.user_id = user.id
        userTrack.track_id = track.id
        userTrack.save
      end
      user.update_attribute('complete', true)
    end
  end
end

