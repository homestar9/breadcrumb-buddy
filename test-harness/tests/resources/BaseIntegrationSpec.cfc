component extends="coldbox.system.testing.BaseTestCase" appMapping="/" {

    property name="wirebox" inject="wirebox";
    property name="jSoup" inject="javaloader:org.jsoup.Jsoup";
    
    // Load on first test
    this.loadColdBox    = true;
    // Never unload until the request dies
    this.unloadColdBox  = false;


    /**
     * Run Before all tests
     */
    function beforeAll() {
        super.beforeAll();
        // Wire up the test object with dependencies
        application.wirebox.autowire( this );
    }

    /**
     * This function is tagged as an around each handler.  All the integration tests we build
     * will be automatically rolled backed. No database corruption
     * 
     * @aroundEach
     */
    function wrapInTransaction( spec ) {
        
        if ( spec.labels.findNoCase( "NoTransaction" ) ) {
            //debug( "No transaction for this spec!" );
            arguments.spec.body();
            return;
        }
        
        transaction action="begin" {
            try {
                arguments.spec.body();
            } catch ( any e ){
                rethrow;
            } finally {
                transaction action="rollback";
            }
        }
    }


}