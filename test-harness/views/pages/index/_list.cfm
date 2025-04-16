<cfscript>
param args.pages = [];
param args.urlPath = "./";
</cfscript>
<cfoutput>

    <ul>
        <cfloop array="#args.pages#" item="item">
            <li>
                <a href="#args.urlPath##item.slug#/">#item.name#</a>
                <cfscript>
                // look for sub pages
                children = prc.allPages.filter( function( page ) {
                    return page.parent == item.id;
                } )
                </cfscript>

                <cfif children.len()>
                    #view( 
                        view = "pages/index/_list",
                        args = {
                            pages = children,
                            urlPath = args.urlPath & item.slug & "/"  
                        }
                    )#
                </cfif>
            </li>
        </cfloop>
    </ul>

</cfoutput>