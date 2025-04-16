component 
    singleton 
{
    property name="settings" inject="coldbox:moduleSettings:breadcrumb-buddy";
    property name="requestService" inject="coldbox:RequestService";
    property name="wirebox" inject="Wirebox";
    property name="renderer" inject="provider:coldbox:renderer";


    function init() {
        return this;
    }

    /**
     * generate
     *
     * @eventName (string) The event name to generate breadcrumbs for. Can match a regex pattern in the events settings or an alias.
     */
    function generate( 
        string eventName = requestService.getContext().getCurrentEvent() 
    ) {
        
        // Get the current request context
        var context = requestService.getContext();
        var rc = context.getCollection();
        var prc = context.getPrivateCollection();
        
        // instantiate a new trail
        var trail = wirebox.getInstance( "BreadcrumbTrail@breadcrumb-buddy" );

        var resolvedEventName = eventName;
        // check for aliases
        if ( variables.settings.aliases.keyExists( eventName ) ){
            resolvedEventName = variables.settings.aliases[ eventName ];
        }

        var ruleFound = false;
        
        // Find and execute matching rule
        for ( var pattern in variables.settings.events ) {

            if ( reFindNoCase( pattern, resolvedEventName ) ) {
                
                var rule = variables.settings.events[ pattern ];
                
                if ( isClosure( rule ) ) {
                    try {
                        rule( trail, context, rc, prc );
                    } catch ( any e ) {
                        writeDump( "Error in breadcrumb rule: " & pattern & " - " & e.message );
                    }
                }

                ruleFound = true;
                break; // First match wins - exit loop
            }
        }

        // if no rule was found, check for a default rule
        if ( 
            !ruleFound && 
            len( settings.defaultEvent ) && 
            variables.settings.events.keyExists( settings.defaultEvent ) 
        ) {
            var defaultRule = variables.settings.events[ settings.defaultEvent ];

            if ( isClosure( defaultRule ) ) {
                try {
                    defaultRule( trail, context, rc, prc );
                } catch ( any e ) {
                    writeDump( "Error in default breadcrumb rule: " & e.message );
                }
            }

        }

        return trail.getCrumbs();
    }

    /**
     * render
     * Renders the breadcrumb trail
     * 
     * @eventName (string) The event name to generate breadcrumbs for. Defaults to the currente event
     * @breadcrumbs (array) overrides any breadcrumbs that might have been generated [ { name: "", url: "" } ]
     */
    function render( 
        string eventName = requestService.getContext().getCurrentEvent(),
        array breadcrumbs
    ) {
        
        // if we don't have a breadcrumbs override, generate one
        if ( !arguments.keyExists( "breadcrumbs" ) ) {
            arguments.breadcrumbs = generate( eventName );
        }

        return renderer.view( 
            view = settings.view,
            module = settings.viewModule,
            args = {
                "breadcrumbs": arguments.breadcrumbs
            }
        )
    }
}


