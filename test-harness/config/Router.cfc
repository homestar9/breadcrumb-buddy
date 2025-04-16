component{

	function configure(){
		setFullRewrites( true );

		route( "posts/:id" ).to( "posts.show" );
        route( "posts" ).to( "posts.index" );
        
        // e-commerce
        route( "categories/:categoriesPath-regex:(.+)/products/:slug" ).to( "products.show" );
        route( "categories/:slug" ).to( "categories.show" );
        route( "categories" ).to( "categories.index" );
        route( "products/:slug" ).to( "products.show" );
        route( "products" ).to( "products.index" );
        
        // Pages
        route( "pages" ).to( "pages.index" );
        route( ":slug" ).to( "pages.show" );
        // route( ":handler/:action?" ).end();
	}

}