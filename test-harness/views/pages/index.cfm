<cfoutput>

    <h1>Pages</h1>

    <div class="lead mb-4">
        Static or dynamic pages with a simple parent/child hierarchy.
    </div>
    
    #view(
        view = "pages/index/_list",
        args = {
            "pages" = prc.rootPages,
            "urlPath" = "./"
        }   
    )#

</cfoutput>