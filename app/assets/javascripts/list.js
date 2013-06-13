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
        targetCarouselItem.append("<h4>"+videoname+"</h4>");
        targetCarouselItem.append("<div style='text-align:center;'><iframe width='560' height='315' src='http://www.youtube.com/embed/"+videoid+"' frameborder='0' allowfullscreen='allowfullscreen'></iframe></div>");
        targetCarouselItem.addClass("loaded");
      }
    );
  };

  $("#c", $(this)).bind("slid", function() {
    $("#trackDetailTitle").text($(".active > span", $(this)).text());
  });

  $("#c").carousel({interval:false});

  $('a[id^=track-]').click(function() {
    $("#trackDetailModal").modal();
    var id = $(this).attr("id");
    // カルーセルを作る
    var carouselInner = $(".carousel-inner").empty();
    var index = 0;
    $("li", $(this).parent().parent()).each(function(i, o){
      var titleNode = $("<span class='hide'>" + $(".track_artist", $(o)).text() + " " + $(".track_name", $(o)).text() + "</span>");
      var bodyNode = $("<div class='item'></div>");
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
