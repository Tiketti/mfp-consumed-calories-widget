using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Communications as Comm;

class mfpconsumedcalorieswidgetView extends Ui.View {
	var consumedCalories = -1;
	
    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
    	
    	//var logo = Ui.loadResource(Rez.Drawables.mfp_64);
        //dc.drawBitmap(50, 20, logo);

		//var logo = new Rez.Drawables.mfp_32;
		//logo.Draw(dc);		
        
    	//dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
    	
    	if(consumedCalories == -1){
    		View.findDrawableById("title").setText("Fetching...");
    		Comm.makeJsonRequest("https://dweet.io:443/get/latest/dweet/for/mfpconsumedandgoal", null, null, method(:handleResponse));
		} else {    
    		View.findDrawableById("title").setText("Consumed calories: \n" + consumedCalories);
		}
    	
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);    	
    }
    
    function handleResponse(responseCode, data) {
	    if(responseCode == 200) {
	    	System.println("code: " + responseCode);
	    	System.println("data: " + data["with"]);
	    	System.println("data.content: " + data["with"][0]["content"]);
	    	System.println("data.content.goal: " + data["with"][0]["content"]["goal"]);
	    	System.println("data.content.consumed: " + data["with"][0]["content"]["consumed"]);
	    	
	    	consumedCalories = data["with"][0]["content"]["consumed"];
	    	
	    	Ui.requestUpdate();
	    	
    	} else {
    		// handle error
    	}	
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

}
