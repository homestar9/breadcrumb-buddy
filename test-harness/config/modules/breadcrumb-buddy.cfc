component {

	function configure(){
		return {
            // Override view if desired
            "view" = "breadcrumbs/index",
            // Override view module if desired
            "viewModule" = "breadcrumb-buddy",
            // Event-Based breadcrumb rules
            "events" = {
                // Home
                "main.index" = function( trail, event, rc, prc ) {
                    trail.push( "Home", event.buildLink( "" ) );
                },

                // Categories
                "categories.index" = function( trail, event, rc, prc ) {
                    trail.parent( "home" )
                        .push( "Categories", event.buildLink( "categories." ) );
                },
                "categories.show" = function( trail, event, rc, prc ) {
                    trail.parent( "categories.index" )
                        .push( prc.category.name, event.buildLink( "categories.#prc.category.id#." ) );
                },

                // Products
                "products.index" = function( trail, event, rc, prc ) {
                    trail.parent( "home" )
                        .push( "Products", event.buildLink( "products." ) );
                },
                
                "products.show" = function( trail, event, rc, prc ) {

                    // if categories exist
                    if ( rc.keyExists( "categoriesPath" ) ) {
                        
                        trail.parent( "categories.index" );
                        
                        var categories = listToArray( rc.categoriesPath, "/" );
                        var parentSlugs = [ "categories" ];
                        
                        categories.each( function( categorySlug ) {
                            var category = prc.allCategories.filter( function( item ) {
                                return item.slug == categorySlug;
                            } );
                            if ( category.len() ) {
                                trail.push( category[ 1 ].name, event.buildLink( "#parentSlugs.toList( "/" )#/#category[ 1 ].slug#." ) );
                                parentSlugs.append( category[ 1 ].slug );
                            }
                        } );
                        
                    } else {
                        trail.parent( "products.index" );
                    }
                    
                    // finally add the current product
                    trail.push( prc.product.name, event.buildLink( "products.#prc.product.slug#." ) );
                },

                // Posts
                "posts.index" = function( trail, event, rc, prc ) {
                    trail.parent( "home" )
                        .push( "Blog", event.buildLink( "posts." ) );
                },
                "posts.show" = function( trail, event, rc, prc ) {
                    trail.parent( "posts.index" )
                        .push( prc.post.name, event.buildLink( "posts.#prc.post.id#." ) );         
                },

                // Pages
                "pages.show" = function( trail, event, rc, prc ) {
                    trail.parent( "home" );

                    var pageHierarchy = [];
                    var currentPage = prc.page;
                    var rootUrl = event.buildLink( "" );
                    var hasParents = len( currentPage.parent );
                
                    // Collect pages from current to root
                    pageHierarchy.append( currentPage );
                    while( hasParents ) {
                        var parent = prc.allPages.filter( function( page ) {
                            return page.id == currentPage.parent;
                        } );
                        if( parent.len() ) {
                            parent = parent[ 1 ];
                            pageHierarchy.append( parent );
                            currentPage = parent;
                            hasParents = len( parent.parent );
                        } else {
                            hasParents = false;
                        }
                    }
                
                    // Build breadcrumb trail in correct order (root to current)
                    var urlBuilder = rootUrl;
                    for ( var i = pageHierarchy.len(); i > 0; i-- ) {
                        var page = pageHierarchy[ i ];
                        urlBuilder &= page.slug & "/";
                        trail.push( page.name, urlBuilder );
                    }
                },

                // Errors
                "errors.onMissingPage" = function( trail, event, rc, prc ) {
                    trail.parent( "home" );
                }
            },
            "aliases": {
                "home" = "main.index"
            }
        };
	}

}
