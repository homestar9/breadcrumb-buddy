<cfscript>
    param args.categories = [];
    param args.urlPath = "./categories/";
    </cfscript>
    <cfoutput>
    
        <ul>
            <cfloop array="#args.categories#" item="item">
                <li>
                    <cfset parentsExist = true />
                    <cfset parents = [] />
                    <cfset currentCategory = item />
                    <cfloop condition="parentsExist">
                    
                        <cfscript>
                        // look for parent categories
                        parent = prc.allCategories.filter( function( category ) {
                            return category.id == currentCategory.parent;
                        } );
                        </cfscript>

                        <cfif !parent.len()>
                            <cfset parentsExist = false />
                            <cfbreak />
                        </cfif>

                        <cfset parents.append( parent[ 1 ] ) />
                        <cfset currentCategory = parent[ 1 ] />

                    </cfloop>

                    <cfloop from="#parents.len()#" to="1" index="i" step="-1">
                        <cfset parent = parents[ i ] />
                        #parent.name# / 
                    </cfloop>

                    <cfset segments = parents.map( function( item ) { return item.slug } ) />
                    
                    <a href="#args.urlPath##( segments.len() ? segments.toList( "/" ) & "/" : '' )##item.slug#/">#item.name#</a>

                </li>
            </cfloop>
            
        </ul>
    
    
    </cfoutput>