component 
    accessors="true"
    hint="I am a breadcrumb trail composed of a list of crumbs leading up to the curent event"
{
    
    property name="crumbs" type="array";

    // DI
    property name="settings" inject="coldbox:moduleSettings:breadcrumb-buddy";
    property name="breadcrumbService" inject="BreadcrumbService@breadcrumb-buddy";
    property name="requestService" inject="coldbox:RequestService";

    function init() {
        variables.crumbs = [];
        return this;
    }

    /**
     * push
     * Appends a crumb onto the breadcrumb trail
     *
     * @name (string) The name of the crumb to add to the trail
     * @link (string) The link to the crumb. If not provided, it will default to the root of the app
     */
    function push( 
        required string name, 
        string link = "" 
    ) {
        
        // otherwise just push the crumb onto the trail
        variables.crumbs.append( {
            "name": name,
            "link": len( link ) ? link : requestService.getContext().buildLink( "" )
        } );
        return this;
    }

    function pushEvent( required string name ) {
        return parent( name );
    }

    /**
     * parent
     * Prepends a parent breadcrumb trail onto the current trail
     * The result will merge the parent trail with the current trail
     *
     * @parentEvent (string) The event name to generate breadcrumbs for. 
     */
    function parent( required string parentEvent ) {
        var parentTrail = breadcrumbService.generate( parentEvent );
        variables.crumbs = parentTrail.append( variables.crumbs, true );
        return this;
    }

}