<cfoutput>

    <h1>Categories</h1>
    
    #view(
        view = "categories/index/_list",
        args = {
            categories = prc.rootCategories
        }   
    )#

</cfoutput>