component {

    variables._categories = [
        { id: 1, parent: "", slug: "electronics", name: "Electronics" },
        { id: 2, parent: "", slug: "new-arrivals", name: "New Arrivals"  },
        { id: 3, parent: "", slug: "brands", name: "Brands" },
        { id: 4, parent: "1", slug: "televisions", name: "Televisions" },
        { id: 5, parent: "3", slug: "samsung", name: "Samsung" },
        { id: 6, parent: "3", slug: "lg", name: "LG" },
        { id: 7, parent: "3", slug: "sony", name: "Sony" }
    ];
    
    // Dummy Data for this app
    variables._pages = [
        { id: 1, parent: "", slug: "about-us", name: "About Us", body: "Content of page 1", categoryId="" },
        { id: 2, parent: "", slug: "contact-us", name: "Contact Us", body: "Content of page 2", categoryId="" },
        { id: 3, parent: "", slug: "star-trek", name: "Star Trek", body: "Content of page 3", categoryId="3" },
        { id: 4, parent: "3", slug: "voyager", name: "Star Trek: Voyager", body: "Content of page 4", categoryId="" },
        { id: 5, parent: "4", slug: "captain-janeway", name: "Captain Janeway", body: "Content of page 5", categoryId="" }
    ];

    variables._products = [
        { id: 1, parent: "", slug: "samsung-transparent-led-tv", name: "Samsung Transparent LED Television", body: "Content of product 1", categories = [ 5, 4, 2 ] },
        { id: 2, parent: "", slug: "lg-oled-tv", name: "LG OLED Television", body: "Content of product 2", categories=[ 6, 4 ] },
        { id: 3, parent: "", slug: "sont-bravia-xr", name: "Sony BRAVIA XR", body: "Content of product 3", categories=[ 7, 4, 2 ] }
    ];
    
    
    function aroundHandler( event, targetAction, eventArguments, rc, prc ) {
    
        try{
    
            // prepare arguments for action call
            var args = {
                event = arguments.event,
                rc    = arguments.rc,
                prc   = arguments.prc
            };

            structAppend( args, eventArguments );

            // execute the action now
            return arguments.targetAction( argumentCollection=args );
    
        } catch ( NotFound e ) {

            return runEvent( 
                event = "errors.onMissingPage",
                eventArguments = {
                    "exception": e
                }
            );

        }
    
    }

}