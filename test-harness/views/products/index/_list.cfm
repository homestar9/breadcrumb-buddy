<cfscript>
param args.products = [];
param args.urlPath = event.buildLink( "products." );
</cfscript>
<cfoutput>

    <ul>
        <cfloop array="#args.products#" item="item">
            <li>
                <a href="#args.urlPath##item.slug#/">#item.name#</a>
            </li>
        </cfloop>
    </ul>

</cfoutput>