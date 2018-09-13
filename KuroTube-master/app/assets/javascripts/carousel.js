$(function() {
  $('.index-videos').slick({
    arrows: true,
    centerMode: false,
    fade: false,
    speed: 300,
    infinite: false,
    slidesToShow: 6,
    slidesToScroll: 1,
    respondTo: 'slider',
    responsive: [{
      breakpoint: 1280,settings: {
        slidesToShow: 5,
        slidesToScroll: 1
      }
    },
    {
      breakpoint: 1070,settings: {
        slidesToShow: 3,
        slidesToScroll: 3
      }
    },
    {
      breakpoint: 855,settings: {
        slidesToShow: 2,
        slidesToScroll: 2
      }
    },
    {
      breakpoint: 640,settings: {
        slidesToShow: 1,
        slidesToScroll: 1
      }
    },
    {
      breakpoint: 435,settings: {
        slidesToShow: 1,
        slidesToScroll: 1
      }
    }
    ]
  });
});
