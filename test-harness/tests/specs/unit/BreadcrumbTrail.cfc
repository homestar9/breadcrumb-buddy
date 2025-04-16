component extends="coldbox.system.testing.BaseTestCase" appMapping="root" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();
		setup();
	}

	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){
		describe( "Breadcrumb Trail", function(){
			beforeEach( function( currentSpec ){
                model = getInstance( "BreadcrumbTrail@breadcrumb-buddy" );
            } );

            it( "can be created", function() {
                expect( model ).toBeComponent();
                expect( model ).toBeInstanceOf( "BreadcrumbTrail" );
            } );

            it( "can push crumbs to the trail", function() {
                
                var validData = {
                    name = "Test",
                    link = "/test"
                }   
                
                model.push( validData.name, validData.link );

                var trail = model.getCrumbs();

                expect( trail ).toBeArray();
                expect( trail.len() ).toBe( 1 );
                expect( trail[ 1 ].link ).toBe( validData.link );
                expect( trail[ 1 ].name ).toBe( validData.name );
            } );

            it( "can prepend parents to the trail", function() {
                
                var context = controller.getRequestService().getContext();
                var product = { id: 1, slug: "test", name: "Test Product" };
                context.setPrivateValue( "product", product );

                model.parent( "products.show" );

                trail = model.getCrumbs();

                expect( trail ).toBeArray();
                expect( trail.len() ).toBe( 3 );
                expect( trail[ 1 ].name ).toBe( "Home" );
                expect( trail[ 2 ].name ).toBe( "Products" );
                expect( trail[ 3 ].name ).toBe( product.name );
            } );
            

		} );
	}

}
