$(function(){
  $('a[id^=artist-]').click(function(){
    if (!$(this).parent().hasClass("active")) {
      $('ul[id^=albums-], ul[id^=tracks-]').hide();
      $('#artists > li').removeClass("active");
      $(this).parent().addClass("active");
      myFadeIn($("#albumBlock"), $('#albums-' + $(this).attr("id").replace("artist-", "")));
    }
  });
  $('a[id^=album-]').click(function(){
    if (!$(this).parent().hasClass("active")) {
      $('ul[id^=tracks-]').hide();
      $('li', $(this).parent().parent()).removeClass("active");
      $(this).parent().addClass("active");
      myFadeIn($("#trackBlock"), $('#tracks-' + $(this).attr("id").replace("album-", "")));
    }
  });

  function myFadeIn(parent, target) {
    parent.css("margin-top", 30);
    parent.hide();
    $("li", target).removeClass("active");
    target.show();
    parent.animate({opacity: "toggle", marginTop: "0px"}, 500);
  };

  youtubeQueryParams = {};
  $("#trackDetailModal").on("show", function() {
    var target = $("#modalTrackDetail", $(this)).empty();
    $("#trackDetailTitle", $(this)).text(youtubeQueryParams.track_artist + " - " + youtubeQueryParams.track_name);
    $.getJSON(
      "http://gdata.youtube.com/feeds/api/videos",
      {
        v : "2",
        q : youtubeQueryParams.q,
        "max-results" : "6",
        alt : "json"
      },
      function(result) {
        var videoid, videoname;
        if (result == undefined || result.feed == undefined || result.feed.entry == undefined || result.feed.entry.length == 0) {
          $("#trackDetailModal .alert").show();
          return;
        }
        $.each(result.feed.entry, function(i, item) {
          videoid = item.media$group.yt$videoid.$t;
          videoname = item.media$group.media$title.$t;
          return false;
        });
        target.append("<h4>"+videoname+"</h4>");
        target.append("<iframe width='640' height='400' src='http://www.youtube.com/embed/"+videoid+"' frameborder='0' allowfullscreen='allowfullscreen'></iframe>");
      });
  });
  $("#trackDetailModal").on("hidden", function() {
    $("#modalTrackDetail", $(this)).empty();
    $(".alert", $(this)).hide();
  });

  $('a[id^=track-]').click(function() {
    var track_artist = $('.track_artist', this).text();
    var track_name   = $(".track_name", this).text();
    var q = track_artist  + " " + track_name;
    youtubeQueryParams = {
      track_artist : track_artist,
      track_name   : track_name,
      q : q
    };
    $("#trackDetailModal").modal();
  });
});
