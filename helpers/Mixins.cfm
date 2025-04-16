<cfscript>

    /**
     * breadcrumbs
     * Allows breadcrumbs() to be available in all handlers/views for easy access
     */ 
    function breadcrumbs() {
        
        // performance: not having to use wirebox every time.
        if ( !variables.keyExists( "breadcrumbService" ) ) {
            variables.breadcrumbService = wirebox.getInstance( "breadcrumbService@breadcrumb-buddy" );
        }
    
        return variables.breadcrumbService;
    }

</cfscript>