<cfoutput>

    <h1>#prc.product.name#</h1>
    
    <div>
        #prc.product.body#
    </div>

    <cfif prc.categories.len()>
        <h2 class="mt-3">Categories</h2>

        #view(
            view = "products/show/_categories",
            args = {
                categories = prc.categories
            }
        )#
    </cfif>

</cfoutput>