/**
* My Event Handler Hint
*/
component
    extends="BaseHandler"
{
    
    function preHandler( event, rc, prc ) {
        prc.allCategories = variables._categories;
        prc.allPages = variables._pages;
    }
    
    // Index
	function index( event,rc, prc ) cache="true" cacheTimeout="30" cacheLastAccessTimeout="15"{
		prc.products = variables._products;
	}


    function show( event,rc, prc ) cache="true" cacheTimeout="30" cacheLastAccessTimeout="15"{
        
        prc.product = variables._products.filter( function( item ) {
            return item.slug == rc.slug;
        } );

        // not found?
        if ( !prc.product.len() ) {
            throw( "Not Found", "NotFound" );
        }

        prc.product = prc.product[ 1 ];
        prc.canonicalUrl = event.buildLink( "products.#prc.product.slug#." );

        rc.pathSegments = listToArray( prc.currentRoutedURL, "/" );

        prc.categories = variables._categories.filter( function( item ) {
            return prc.product.categories.find( item.id );
        } );
	}

}