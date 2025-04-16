<cfparam name="args.breadcrumbs" default="#[]#" />
<cfoutput>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <cfloop array="#args.breadcrumbs#" item="item" index="index">
                <!--- special rendering for the current item --->
                <cfif ( index == args.breadcrumbs.len() )>
                    <li class="breadcrumb-item active" aria-current="page">#item.name#</li>
                <cfelse>
                    <li class="breadcrumb-item"><a href="#item.link#">#item.name#</a></li>
                </cfif>
            </cfloop>
        </ol>
    </nav>
</cfoutput>