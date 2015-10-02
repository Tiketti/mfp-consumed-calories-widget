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
    	System.println("onShow() called.");    	
		fetchData();
    }
    
	function fetchData() {
		setMainText("Fetching...");
		setErrorMessage("");
		Comm.makeJsonRequest("https://dweet.io:443/get/latest/dweet/for/mfpconsumedandgoal", null, null, method(:handleResponse));
	}
	
    //! Update the view
    function onUpdate(dc) {
    	System.println("onUpdate function called.");    	
    	
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
	    	setMainText("Consumed calories: \n" + consumedCalories);
    	} else {
    		System.println("Entered error handling.");
			setMainText("");
			setErrorMessage("Error: " + responseCode + "\npress [START] to retry.");
    	}	
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }
    
    function setMainText(text) {
    	System.println("Setting main text: '" + text  + "'");
    	View.findDrawableById("mainText").setText(text);
    	Ui.requestUpdate();
    }
    
    function setErrorMessage(text) {
    	System.println("Setting error message: '" + text  + "'");
    	View.findDrawableById("errorMessage").setText(text);
    	Ui.requestUpdate();
    }

}
