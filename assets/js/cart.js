;(function($){

    $(document).on('ready', function () {
        function formatPrice(price) {
          return (price / 100).toFixed(2) + '€';
        }

        function updateCart(data) {
          var formated = (data.amount / 100).toFixed(2) + '€';

          $('.cart .items').val(data.items);
          $('.cart #payment').data('amount', data.amount);
          $('.cart #payment').attr('data-amount', data.amount);
          $('.cart #subtotal').text(formatPrice(data.subtotal));
          $('.cart #total').text(formatPrice(data.amount));
          $('.cart #taxes').text(formatPrice(data.taxes));
          $('.cart #price').text(formatPrice(data.price));
        }

        $.get('/cart', { locale: $('html').attr('lang') }).done(function (data) {
          updateCart(data);
        });

        $('.cart .add').click(function(event) {
          $.post('/cart/add').done(function (data) {
            updateCart(data);
          });

          event.preventDefault();
        });

        $('.cart .subtract').click(function(event) {
          $.post('/cart/subtract').done(function (data) {
            updateCart(data);
          });

          event.preventDefault();
        });

        $('.cart form').submit(function( event ) {
          $('.cart .loading').show();
        });
    });

})( jQuery );
