;(function($){

    $(document).on('ready', function () {
        $.get('/cart').done(function (data) {
          $('.cart .items').val(data.items);
        });

        $('.cart .add').click(function(event) {
          $.post('/cart/add').done(function (data) {
            $('.cart .items').val(data.items);
          });

          event.preventDefault();
        });

        $('.cart .subtract').click(function(event) {
          $.post('/cart/subtract').done(function (data) {
            $('.cart .items').val(data.items);
          });

          event.preventDefault();
        });
    });

})( jQuery );
