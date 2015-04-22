$('document').ready(function() {
	$('.ui.checkbox').checkbox();
	$('.ui.radio.checkbox').checkbox();
	$('select.dropdown').dropdown();
	
	$('.rating').rating({
        maxRating: 5
    });
    
    $('#friendly_index_rating').rating('setting', 'onRate', function(value) {
        $('#friendly_index_field').val(value);
    });
    
    $('#energy_index_rating').rating('setting', 'onRate', function(value) {
        $('#energy_index_field').val(value);
    });
    
    $('#adaptability_index_rating').rating('setting', 'onRate', function(value) {
        $('#adaptability_index_field').val(value);
    });
})