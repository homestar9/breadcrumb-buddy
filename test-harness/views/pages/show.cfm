<cfoutput>

    <h1>#prc.page.name#</h1>
    
    <div>
        #prc.page.body#
    </div>

    <cfif prc.children.len()>

        <h2 class="mt-3">Sub Pages</h2>

        #view(
            view = "pages/index/_list",
            args = {
                "pages" = prc.children,
                "urlPath" = prc.canonicalUrl
            }
        )#

    </cfif>

</cfoutput>