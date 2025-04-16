<cfoutput>

    <h1>Products</h1>
    
    #view(
        view = "products/index/_list",
        args = {
            "products" = prc.products
        }   
    )#

</cfoutput>