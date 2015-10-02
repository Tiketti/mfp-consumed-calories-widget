using Toybox.Application as App;
using Toybox.WatchUi as Ui;

var mfpWidget;

class mfpconsumedcalorieswidgetApp extends App.AppBase {

    //! onStart() is called on application start up
    function onStart() {
    }

    //! onStop() is called when your application is exiting
    function onStop() {
    }

    //! Return the initial view of your application here
    function getInitialView() {
    	mfpWidget = new mfpconsumedcalorieswidgetView();
        return [ mfpWidget, new MfpWidgetDelegate() ];
    }

}

class MfpWidgetDelegate extends Ui.InputDelegate {
    function onKey(evt) {
        if (evt.getKey() == Ui.KEY_ENTER) {
            mfpWidget.fetchData();
            return true;
        }
        return false;
    } 
}