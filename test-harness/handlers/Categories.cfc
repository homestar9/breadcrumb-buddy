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
		prc.rootCategories = variables._categories.filter( function( item ) {
            return !len( item.parent );
        } );
	}


    function show( event,rc, prc ) cache="true" cacheTimeout="30" cacheLastAccessTimeout="15"{

        rc.pathSegments = listToArray( prc.currentRoutedURL, "/" ).deleteAt( 1 );
        prc.result = findBySegments( rc.pathSegments );
        prc.category = prc.result.entity;
        prc.canonicalUrl = event.buildLink( "categories.#prc.result.canonical.toList( '/' )#." );

        prc.subcategories = variables._categories.filter( function( item ) {
            return item.parent == prc.category.id;
        } );

        prc.products = variables._products.filter( function( item ) {
            return item.categories.find( prc.category.id )
        } );
        
	}


    /**
     * findBySegments
     * @segments (array)
     */
    private function findBySegments( required array segments ) {
        
        var currentParent = "";
        var canonical = [];
        var currentEntity = {};

        for ( var a=1; a<=segments.len(); a++ ) {
            
            var slug = segments[ a ];
            
            currentEntity = variables._categories.filter( function( item ) {
                return item.slug == slug && item.parent == currentParent;
            } );

            if ( !currentEntity.len() ) {
                throw( "Not Found", "NotFound" );
            }

            currentEntity = currentEntity[ 1 ];

            // Prepare for the next iteration
            currentParent = currentEntity.id;
            canonical.append( currentEntity.slug );

        }
        
        return {
            entity: currentEntity,
            canonical: canonical
        };

    }
}