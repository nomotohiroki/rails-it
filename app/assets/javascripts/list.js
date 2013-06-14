var tag = document.createElement('script');

tag.src = "//www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);


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

  var playerList = [];
  function loadMovie(targetCarouselItem) {
    if (targetCarouselItem.hasClass("loaded")) {
      return;
    }
    var q = $("span", targetCarouselItem).text();
    $.getJSON(
      "http://gdata.youtube.com/feeds/api/videos",
      {
        v : "2",
        q : q,
        "max-results" : "6",
        alt : "json"
      },
      function(result) {
        var videoid, videoname;
        if (result == undefined || result.feed == undefined || result.feed.entry == undefined || result.feed.entry.length == 0) {
          targetCarouselItem.append("<div class='alert'>Sorry, We cannot found this songs movie from youtube</div>");
          return;
        }
        $.each(result.feed.entry, function(i, item) {
          videoid = item.media$group.yt$videoid.$t;
          videoname = item.media$group.media$title.$t;
          return false;
        });
        targetCarouselItem.append("<div id='player-"+targetCarouselItem.attr("id")+"' class='player'><span class='hide'>"+videoid+"</span></div>");
        targetCarouselItem.append("<h4>"+videoname+"</h4>");
        playerList[playerList.length] = new YT.Player('player-'+targetCarouselItem.attr("id"), {
          height: '315',
          width: '560',
          videoId: videoid,
          events :{
            'onStateChange': onPlayerStateChange
          }
        });
        targetCarouselItem.addClass("loaded");
      }
    );
  };

  var playingPlayer;
  var playCurrent = false;
  function onPlayerStateChange(e) {
    if (e.data == YT.PlayerState.PLAYING) {
      if (playingPlayer) {
        playingPlayer.stopVideo();
      }
      playingPlayer = e.target;
    } else {
      playingPlayer = undefined;
      if (e.data == YT.PlayerState.ENDED) {
        $("#c").carousel("next");
        playCurrent = true;
      }
    }
  }

  $("#c", $(this)).bind("slid", function() {
    $("#trackDetailTitle").text($(".active > span.title", $(this)).text());
    if (playingPlayer) {
      playingPlayer.stopVideo();
      playingPlayer = undefined;
    }
    if (playCurrent) {
      var index = $(".active", $(this)).index();
      playerList[index].playVideo();
      playingPlayer = playerList[index];
      playCurrent = false;
    }
  });

  $("#c").carousel({interval:false});

  $("#trackDetailModal").on("hidden", function() {
    $(".carousel-inner", $(this)).empty();
  });

  $('a[id^=track-]').click(function() {
    $("#trackDetailModal").modal();
    playerList = [];
    var id = $(this).attr("id");
    var carouselInner = $(".carousel-inner").empty();
    var index = 0;
    $("li", $(this).parent().parent()).each(function(i, o){
      var titleNode = $("<span class='hide title'>" + $(".track_artist", $(o)).text() + " " + $(".track_name", $(o)).text() + "</span>");
      var bodyNode = $("<div id='item-"+$("a",$(this)).attr("id")+"' class='item'></div>");
      if ($("a",$(this)).attr("id") == id) {
        bodyNode.addClass("active");
        $("#trackDetailTitle").text(titleNode.text());
      }
      bodyNode.append(titleNode);
      loadMovie(bodyNode);
      carouselInner.append(bodyNode);
    });
  });
});
