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
  function loadMovie(targetCarouselItem, index) {
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
          targetCarouselItem.append("<div class='alert'>Sorry, We cannot found this tracks movie from youtube</div>");
          return;
        }
        var thumbsElm;
        $.each(result.feed.entry, function(i, item) {
          videoid = item.media$group.yt$videoid.$t;
          videoname = item.media$group.media$title.$t;
          if (i == 0) {
            targetCarouselItem.append("<div class='playerholder'><div id='player-"+targetCarouselItem.attr("id")+"' class='player'><span class='hide'>"+videoid+"</span></div></div>");
            targetCarouselItem.append("<h4>"+videoname+"</h4>");
            playerList[index] = new YT.Player('player-'+targetCarouselItem.attr("id"), {
              height: '315',
              width: '560',
              videoId: videoid,
              events :{
                'onStateChange': onPlayerStateChange
              }
            });
            targetCarouselItem.addClass("loaded");
          }
          if (i <= 4) {
            if (thumbsElm == undefined) {
              targetCarouselItem.append("<h6>other related videos</h6>");
              targetCarouselItem.append("<ul id='thumbs'></ul>");
              thumbsElm = $("#thumbs", targetCarouselItem);
            }
            var c = i == 0 ? " class='current'" : "";
            thumbsElm.append("<li"+c+"><a href='javascript:void(0);' class='thumb-"+videoid+"'><img src='"+item.media$group.media$thumbnail[0].url+"' title='"+videoname+"'/></a></li>");
          }
        });
        $('a', thumbsElm).click(function() {
          if (!$(this).parent().hasClass("current")) {
            $("li", $(this).parent().parent()).removeClass("current");
            var target = $(this).parent().parent().parent();
            var videoid = $(this).attr("class").replace("thumb-", "");
            var videoname = $('img', $(this)).attr("title");
            video(target, videoid, videoname);
            $(this).parent().addClass("current");
          }
        });
      }
    );
  };

  var lock = false;
  function video(o, videoid, videoname) {
    if (lock) {
      return;
    }
    lock = true;
    $('.playerholder', o).html("<div id='player-"+o.attr("id")+"' class='player'><span class='hide'>"+videoid+"</span></div>");
    $("h4", o).text(videoname);
    var currentPlayer = playerList[$(".item", o.parent()).index(o)];
    if (currentPlayer != undefined && currentPlayer.getPlayerState() == 1) {
      currentPlayer.stopVideo();
    }
    playerList[$(".item", o.parent()).index(o)] = new YT.Player('player-'+o.attr("id"), {
      height: '315',
      width: '560',
      videoId: videoid,
      events :{
        'onStateChange': onPlayerStateChange
      }
    });
    lock = false;
  }


  function onPlayerStateChange(e) {
    if (e.data == YT.PlayerState.ENDED) {
      $("#c").carousel("next");
    }
  }

  $("#c").bind("slide", function() {
    for (var i=0; i<playerList.length; i++) {
      var player = playerList[i];
      if (playerList[i] != undefined && playerList[i].getPlayerState() == 1) {
        playerList[i].stopVideo();
      }
    }
  });

  $("#c").bind("slid", function() {
    $("#trackDetailTitle").text($(".active > span.title", $(this)).text());
    for (var i=0; i<playerList.length; i++) {
      if (playerList[i] != undefined && playerList[i].getPlayerState() == 1) {
        playerList[i].stopVideo();
      }
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
    playerList = new Array($("li", $(this).parent().parent()).length);
    $("li", $(this).parent().parent()).each(function(i, o){
      var titleNode = $("<span class='hide title'>" + $(".track_artist", $(o)).text() + " " + $(".track_name", $(o)).text() + "</span>");
      var bodyNode = $("<div id='item-"+$("a",$(this)).attr("id")+"' class='item'></div>");
      if ($("a",$(this)).attr("id") == id) {
        bodyNode.addClass("active");
        $("#trackDetailTitle").text(titleNode.text());
      }
      bodyNode.append(titleNode);
      loadMovie(bodyNode, i);
      carouselInner.append(bodyNode);
    });
  });
});
