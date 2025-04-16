/**
 * Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 */
component {

	// Module Properties
	this.title 				= "breadcrumb-buddy";
	this.author 			= "Angry Sam Productions, Inc.";
	this.webURL 			= "https://www.angrysam.com";
	this.description 		= "Handles breadcrumb navigation for ColdBox apps";
	this.version 			= "1.0.0";

	// Model Namespace
	this.modelNamespace		= "breadcrumb-buddy";

	// CF Mapping
	this.cfmapping			= "breadcrumb-buddy";

	// Dependencies
	this.dependencies 		= [];

    // Application helper
    this.applicationHelper 	= [ "helpers/Mixins.cfm" ];

	/**
	 * Configure Module
	 */
	function configure(){
		settings = {
            // Override view if desired
            "view" = "breadcrumbs/index",
            // Override view module if desired
            "viewModule" = "breadcrumb-buddy",
            // if no matching rule found, default to this event
            "defaultEvent": "main.index",
            // Event-Based breadcrumb rules
            "events" = {
                "main.index": function( trail, event, rc, prc ) {
                    trail.push( "Home", event.buildLink( "" ) );
                }
            },
            // Aliases for trail.parent() calls
            "aliases": {
                "home" = "main.index"
            }
		};
	}

	/**
	 * Fired when the module is registered and activated.
	 */
	function onLoad(){

	}

	/**
	 * Fired when the module is unregistered and unloaded
	 */
	function onUnload(){

	}

}
