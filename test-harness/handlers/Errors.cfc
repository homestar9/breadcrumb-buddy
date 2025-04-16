component {

	/**
	 * Default Action
	 */
	function index( event, rc, prc ) {
		return "not implemented";
	}
    

    /**
     * onMissingPage
     * 404 Error Handler: For displaying friendly missing page errors
     * Note: should fire for missing events and actions too
     *
     * @event 
     * @rc 
     * @prc 
     */
    function onMissingPage( event, rc, prc ) {
        
        prc.currentRouteRecord.statusCode = 404;
        prc.currentRouteRecord.statusText = "Not Found";
        prc.pageTitle = "Page Not Found";

        //event.overrideEvent( "errors.onMissingPage" ); // bypasses event cache on the current event! Bad!
        rc.event = "errors.onMissingPage"; // manually set the event to the error page

        // Set a page for rendering and a 404 header
        event.setView( "errors/onMissingPage" ).setHTTPHeader( "404", "Not Found" );
    }

}
