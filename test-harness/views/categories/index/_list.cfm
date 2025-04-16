<cfscript>
param args.categories = [];
param args.urlPath = "./categories/";
</cfscript>
<cfoutput>

    <ul>
        <cfloop array="#args.categories#" item="item">
            <li>
                <a href="#args.urlPath##item.slug#/">#item.name#</a>
                <cfscript>
                // look for sub categories
                subcategories = prc.allCategories.filter( function( category ) {
                    return category.parent == item.id;
                } )
                </cfscript>

                <cfif subcategories.len()>
                    #view( 
                        view = "categories/index/_list",
                        args = {
                            categories = subcategories,
                            urlPath = args.urlPath & item.slug & "/"
                        }
                    )#
                </cfif>
            </li>
        </cfloop>
        
    </ul>


</cfoutput>