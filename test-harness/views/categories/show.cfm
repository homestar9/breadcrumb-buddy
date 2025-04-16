<cfoutput>

    <h1>#prc.category.name#</h1>

    <h2>Subcategories</h2>

    <cfif prc.subcategories.len()>
        #view( 
            view = "categories/index/_list",
            args = {
                categories = prc.subcategories,
                urlPath = event.buildLink( "categories.#prc.category.slug#." )
            } 
        )#
    <cfelse>
        <p>No subcategories</p>
    </cfif>
    
    
    <h2>Products</h2>

    <cfif prc.products.len()>
        #view( 
            view = "products/index/_list",
            args = {
                products = prc.products,
                urlPath = prc.canonicalUrl & "products/"
            } 
        )#
    <cfelse>
        <p>No pages</p>
    </cfif>

    
</cfoutput>