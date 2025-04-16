<cfoutput>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>HTML 5 Boilerplate</title>
        <base href="#event.getHTMLBaseURL()#" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">

    </head>
    <body>

        <nav class="navbar navbar-expand-lg bg-dark mb-3" data-bs-theme="dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="./">Breadcrumb Buddy</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="##navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="./pages/">Pages</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./posts/">Blog</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./categories/">Categories</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./products/">Products</a>
                    </li>
                </ul>
                </div>
            </div>
        </nav>
        
        <div class="container">

            <div class="border px-3 pt-3 mb-3 bg-light">
            
                #breadcrumbs().render()#

            </div>

            <main class="mb-4">
                #view()#
            </main>

            <hr />

            <cfif prc.keyExists( "canonicalUrl" )>
                <cfdump var="#prc.canonicalUrl#" label="Canonical URL">
            </cfif>
            
            <cfdump var="#rc#" top="2" label="Request Collection">

            <cfdump var="#breadcrumbs().generate()#" label="Breadcrumb Trail">

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
    </body>
    </html>
</cfoutput>
