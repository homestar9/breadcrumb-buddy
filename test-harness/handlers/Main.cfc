/**
* My Event Handler Hint
*/
component
    extends="BaseHandler"
{

	// Index
	any function index( event,rc, prc ){
		prc.pages = variables._pages;
        event.setView( "main/index" );
	}

}