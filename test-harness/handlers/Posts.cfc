/**
* My Event Handler Hint
*/
component
    extends="BaseHandler"
{

	// Dummy Data for this handler
    variables._posts = [
        { id: 1, name: "Post 1", body: "Content of post 1" },
        { id: 2, name: "Post 2", body: "Content of post 2" },
        { id: 3, name: "Post 3", body: "Content of post 3" }
    ];
    
    
    // Index
	function index( event,rc, prc ) cache="true" cacheTimeout="30" cacheLastAccessTimeout="15"{
		prc.posts = variables._posts;
        event.setView( "posts/index" );
	}


    function show( event,rc, prc ) cache="true" cacheTimeout="30" cacheLastAccessTimeout="15"{

        prc.post = variables._posts.filter( function( item ) {
            return item.id == rc.id;
        } );

        // not found?
        if ( !prc.post.len() ) {
            throw( "Not Found", "NotFound" );
        }

        prc.post = prc.post[ 1 ];
        
        event.setView( "posts/show" );
	}

}