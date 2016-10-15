$( document ).ready(function() {
  $("#points").infinitescroll({
  	loading: {
		finishedMsg: "",
		msgText:     "",
		img:         ""
  	},
  	loadingImg:      "",
    loadingText:     "",
    navSelector:     "nav.pagination",
    nextSelector:    "nav.pagination a[rel=next]",
    itemSelector:    "div.point",
    animate:         false,
    bufferPx:        600,
    errorCallback:   function(){
    	  $(".paginator").hide();
    }
  });
});
