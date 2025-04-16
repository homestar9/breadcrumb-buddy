<cfoutput>

    <h1>Posts</h1>
    
    <ul>
        <cfloop array="#prc.posts#" item="item">
            <li>
                <a href="/posts/#item.id#/">#item.name#</a>
            </li>
        </cfloop>
    </ul>

</cfoutput>