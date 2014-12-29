function popu_open(fid){
	dialog_overlay(1);
	$('#'+fid).show();	
}

function popu_close(fid){
	dialog_overlay(0);
	$('#'+fid).hide();
}

function dialog_overlay(op){
	if(op == 1)
		$('.popup_overlay').show();
	else
		$('.popup_overlay').hide();	
}