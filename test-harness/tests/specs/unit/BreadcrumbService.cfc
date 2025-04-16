component extends="tests.resources.BaseIntegrationSpec" appMapping="root" {

    variables.validData = {
        product: { id: 1, slug: "test", name: "Test Product" }
    };
    
    /*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();
	}

	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){
		describe( "Breadcrumb Service", function(){
			beforeEach( function( currentSpec ){
                setup();
                model = getInstance( "BreadcrumbService@breadcrumb-buddy" );
            } );

            it( "can be created", function() {
                expect( model ).toBeComponent();
                expect( model ).toBeInstanceOf( "BreadcrumbService" );
            } );

            it( "can generate breadcrumbs", function() {
                var context = controller.getRequestService().getContext();
                var trail = model.generate();

                expect( trail ).toBeArray();
                expect( trail.len() ).toBe( 1 );
                expect( trail[ 1 ].link ).toBe( context.buildLink( "" ) );
                expect( trail[ 1 ].name ).toBe( "Home" );
            } );

            it( "can generate breadcrumbs with a custom event", function() {
                
                var context = controller.getRequestService().getContext();
                context.setPrivateValue( "product", validData.product );
                
                var trail = model.generate( "products.show" );

                expect( trail ).toBeArray();
                expect( trail.len() ).toBe( 3 );
                expect( trail[ 1 ].link ).toBe( context.buildLink( "" ) );
                expect( trail[ 1 ].name ).toBe( "Home" );
                expect( trail[ 2 ].link ).toBe( context.buildLink( "products." ) );
                expect( trail[ 2 ].name ).toBe( "Products" );
                expect( trail[ 3 ].link ).toBe( context.buildLink( "products.#validData.product.slug#." ) );
                expect( trail[ 3 ].name ).toBe( validData.product.name );
            } );

            it( "can generate default breadcrumbs when passed an unknown event", function() {
                
                var context = controller.getRequestService().getContext();
                var trail = model.generate( "idontexist.show" );

                expect( trail ).toBeArray();
                expect( trail.len() ).toBe( 1 );
                expect( trail[ 1 ].link ).toBe( context.buildLink( "" ) );
                expect( trail[ 1 ].name ).toBe( "Home" );
            } );

            it( "can render breadcrumb HTML", function() {

                var context = controller.getRequestService().getContext();
                context.setPrivateValue( "product", validData.product );
                
                var trail = model.render( "products.show" );

                var doc = jSoup.parse( trail );

                // should have a top-level nav element with aria-label attribute
                var nav = doc.select("nav[aria-label=breadcrumb]");
                expect( nav ).toHaveLength(1, "Nav element with aria-label='breadcrumb' should exist");
                expect( nav.first().tagName() ).toBe("nav", "Top-level element should be nav" );

                // should have three breadcrumb items in li elements
                var items = doc.select("ol.breadcrumb li.breadcrumb-item");
                expect(items).toHaveLength(3, "There should be exactly three breadcrumb items");

                items.each(function(item, index) {
                    expect(item.tagName()).toBe("li", "Breadcrumb item " & (index + 1) & " should be an li element");
                });

                // get the root of the URL for testing
                var baseHref = context.buildLink( "" );

                // should have correct links for breadcrumb items
                var expectedLinks = [
                    baseHref,
                    baseHref & "products/",
                    "" // Last item has no link as it's active
                ];
                var items = doc.select("ol.breadcrumb li.breadcrumb-item");
                
                items.each(function(item, index) {
                    var link = item.select("a");
                    if ( link.len() ) {
                        link = link.first();
                    } else {
                        link = "";
                    }
                    if (index <= 2) {
                        expect(link).notToBeNull("Item " & (index + 1) & " should have a link");
                        expect(link.attr("href")).toBe(expectedLinks[index], "Item " & (index + 1) & " link should match");
                    } else {
                        expect(link).toBe("", "Last item should not have a link. It was #link#");
                    }
                });

                // should have correct text for breadcrumb items
                var expectedText = [ "Home", "Products", validData.product.name ];
                var items = doc.select("ol.breadcrumb li.breadcrumb-item");
                
                items.each(function(item, index) {
                    var text = item.text();
                    expect(text).toBe(expectedText[index], "Item " & (index + 1) & " text should be " & expectedText[index]);
                });

            } );

		} );
	}

}
