# Breadcrumb-Buddy (Public BETA)

<img src="https://github.com/homestar9/breadcrumb-buddy/blob/master/breadcrumb-buddy.svg?raw=true" width="300" alt="Breadcrumb-Buddy Logo" />

**Breadcrumb-Buddy** is a lightweight ColdBox module that simplifies breadcrumb navigation for your web applications. It generates dynamic breadcrumbs based on ColdBox events, supports aliases for intuitive usage, and allows recursive entity hierarchies (e.g., nested pages). It's plug-and-play with minimal setup, perfect for blogs, CMS, or any app needing clear navigation trails.

This module was inspired from the very well thought out [Laravel-Breadcrumbs](https://github.com/diglactic/laravel-breadcrumbs) package. This module is not a port of that package. It was designed to bring similar breadcrumb functionality to ColdBox.

## Requirements

- **ColdBox**: 7.0+
- **CFML Engines**: 
    - ACF 2021+
    - Lucee 5.3+

## Features

- **Event-Based Rules**: Define breadcrumbs using ColdBox event patterns (e.g., `main.index`, `posts.show`).
- **Aliases**: Use friendly names for parents like `trail.parent("home")` instead of `main.index`.
- **Recursive Hierarchies**: Supports dynamic page hierarchies (e.g., `Home > Category > Subcategory > Page`).
- **Plug-and-Play**: Minimal configuration, easy to override.
- **Mixin Convenience**: Easy access in your handlers, layouts, or views simply by calling `breadcrumbs()`
- **100% Gluten-Free**: No dependencies, no bloat. 💪

## Installation

Install `Breadcrumb-Buddy` via CommandBox:

```bash
box install breadcrumb-buddy
```

This adds the module to your ColdBox app under `modules/breadcrumb-buddy`, by convention.

## Quick Start

1. **Install the Module** (see above).
2. **Render Breadcrumbs** in your layout or view (e.g., `views/layouts/Main.cfm`):

```cfc
// Somewhere in your layout or view
#breadcrumbs().render()#
```

3. **Customize Rules** in `config/ColdBox.cfc` or `/config/modules/breadcrumb-buddy.cfc` to override default breadcrumbs. See configuration section below for details.

4. **Styling the Output**: By default, the module will output the breadcrumbs in a simple HTML list. You can customize the output by creating your own view and updating the configuration. You can style the breadcrumbs using SASS/CSS classes or frameworks like Bootstrap. Example HTML output after calling `render()`:

```html
<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="./">Home</a></li>
        <li class="breadcrumb-item"><a href="./posts/">Blog</a></li>
        <li class="breadcrumb-item active" aria-current="page">My Blog Post</li>
    </ol>
</nav>
```

## Configuration

`Breadcrumb-Buddy` is configured in `config/ColdBox.cfc` or `/config/modules/breadcrumb-buddy.cfc`. The following settings are available:

- **view**: Template for rendering breadcrumbs (default: `breadcrumbs/index`).
- **viewModule**: Module hosting the view (default: `breadcrumb-buddy`).
- **events**: Struct of event patterns to breadcrumb rules (closures).
- **aliases**: Map of shorthand names to event patterns that can be used when making `parent()` calls. (e.g., `home: main.index`).

### Default Configuration

```cfc
settings = {
    // Override view if desired
    "view" = "breadcrumbs/index",
    // Override view module if desired
    "viewModule" = "breadcrumb-buddy",
    // if no matching rule found, default to this event
    "defaultEvent": "main.index",
    // Event-Based breadcrumb rules
    "events" = {
        "main.index": function( trail, event, rc, prc ) {
            trail.push( "Home", event.buildLink( "" ) );
        }
    },
    // Aliases for trail.parent() calls
    "aliases": {
        "home" = "main.index"
    }
};
```

### Overriding Configuration

Add to `config/ColdBox.cfc` or `/config/modules/breadcrumb-buddy.cfc`:

```cfc
// Coldbox.cfc example configuration
moduleSettings = {
    "breadcrumb-buddy": {
        // Override view if desired
        "view" = "breadcrumbs/index",
        // Override view module if desired
        "viewModule" = "breadcrumb-buddy",
        // if no matching rule found, default to this event
        "defaultEvent": "main.index",
        // Event-Based breadcrumb rules
        "events" = {
            "main.index": function( trail, event, rc, prc ) {
                trail.push( "Home", event.buildLink( "" ) );
            },
            // Custom event rules for blog post listing page
            "posts.index": function( trail, event, rc, prc ) {
                trail.parent( "home" )
                    .push( "Blog", event.buildLink( "blog" ) );
            },
            // Custom event rules for blog post show page
            "posts.show": function( trail, event, rc, prc ) {
                trail.parent( "home" )
                    .push( "Blog", event.buildLink( "blog" ) )
                    .push( prc.post.getName(), event.buildLink( "posts/#prc.post.getId()#" ) );
            }
        },
        // Aliases for trail.parent() calls
        "aliases": {
            "home" = "main.index"
        }
    };
};
```

## Usage

### Defining Rules

Rules are closures in `settings.events`, keyed by event patterns (regex). Each closure receives:
- `trail`: `BreadcrumbTrail` instance to build crumbs.
- `event`: ColdBox event object.
- `rc`: Request collection
- `prc`: Private collection.

The beauty of using closures like this is that you are only limited by your own creativity. You can use any entity, structure, or logic to build your breadcrumb trail.

Example rule:

```cfc
"posts.index": function( trail, event, rc, prc ) {
    // Inherit home crumbs
    trail.parent( "home" ) 
        // Push the blog post listing page
        .push( "Blog", event.buildLink( "blog" ) );
},
"posts.show": function( trail, event, rc, prc ) {
    // Inherit Blog crumbs
    trail.parent( "posts.index" ) 
         // Push the current post
         .push( prc.post.getName(), event.buildLink( "posts/#prc.post.getId()#" ) ); 
}
```

### Using Aliases

Aliases let you use friendly names:

```cfc
trail.parent( "home" ); // Resolves to main.index
```

Define in `settings.aliases`:

```cfc
"aliases": {
    "home": "main.index",
    "blog": "posts.index"
}
```

**Note** You cannot use aliases when calling `trail.push()`. For details, see the Future Roadmap section below.

### Trail Object Methods

Each rule closure receives a `trail` object with methods to build breadcrumbs:

- **trail.push( name, link )**:
  - Adds a crumb or rule-based crumbs.
  - `name`: Text (e.g., "Home Page").
  - `link`: Optional URL.

- **trail.parent( eventName )**:
  - Prepends crumbs from another event (e.g., `parent("posts.index")`).
  - You may use aliases here (e.g., `parent("home")`).

## Rule Examples

### Blog Example

For a blog at `/posts/123` (events: `posts.index`, `posts.show` ):

```cfc
"posts.show": function( trail, event, rc, prc ) {
    // Inherit the home crumbs using an alias
    trail.parent( "home" )
        // Push the blog post listing page
        .push( "Blog", event.buildLink( "posts" ) )
        // Push the current post
        .push( prc.post.getName(), event.buildLink( "posts.#prc.post.getId()#" ) );
}
```

Crumbs:

```json
[
    { "name": "Home", "link": "/" },
    { "name": "Blog", "link": "/posts" },
    { "name": "My Post", "link": "/posts/123" }
]
```

### Page Hierarchy Example

For `/about-us/jobs` (event: `pages.show`):

In the following example, we are using a `page` entity to build the breadcrumb trail. The `page` entity represents a hierarchical (parent/child) relationship that allows us to traverse the page hierarchy from the current page to the root page.  The `page` object has a method `getParent()` that returns the parent page object, and a method `hasParent()` that checks if the page has a parent. The `isLoaded()` method checks if the page object is loaded. Substitute the `page` object with your own entity or structure as needed.

```cfc
// Pages
"pages.show" = function( trail, event, rc, prc ) {
    // prepend the parent page crumbs
    trail.parent( "home" );

    // create a variable to hold the page hierarchy (current to root)
    var pageHierarchy = [ page ]; // add the current page to the hierarchy
    var currentPage = prc.page; // current page object
    var rootUrl = event.buildLink( "" );
    var hasParents = currentPage.hasParent(); // check if the page has a parent

    // Collect pages from current to root
    while( hasParents ) {
        // get the parent page object
        var parent = currentPage.getParent(); 
        
        if( parent.isLoaded() ) {
            // add the parent page to the hierarchy
            pageHierarchy.append( parent ); 
            // set the current page to the parent page
            currentPage = parent; 
            // check if the parent page has a parent
            hasParents = parent.hasParent(); 
        } else {
            // stop if the parent page is not loaded
            hasParents = false; 
        }

    }

    // Build breadcrumb trail in correct order (root to current)
    var urlBuilder = rootUrl;
    // reverse the page hierarchy to get the correct order
    pageHierarchy.reverse().each( function( page ) {
        urlBuilder &= page.slug & "/";
        trail.push( page.name, urlBuilder );
    } );
},
```

Crumbs:

```json
[
    { "name": "Home", "link": "/" },
    { "name": "About Us", "link": "/about-us" },
    { "name": "Jobs", "link": "/about-us/jobs" }
]
```

### How to Handle 404 Pages and Other Errors

You can define a rule for handling 404 pages or other errors by matching the event name you use for your error handling. For example, if you have a custom error event like `errors.onMissingPage`, you can define a rule for it in your configuration.

**Coldbox Gotcha:**
If you use an around handler pattern to catch errors, you may need to set the `event` object in the `rc` collection to ensure the breadcrumbs are built correctly. This is because calling `runEvent()` does not change the current event for the request.

There are several ways to work around this behavior. One way is to use the `event.overrideEvent()` method to set the event in the current request. Side note: `overrideEvent()` will bypass the event cache for the current event, which may or may not be desirable based on your use case.  The second option is to simply set the event in the `rc` collection. This will not bypass the event cache, and will still trigger the desired breadcrumb rule.

```cfc
// Common aroundHandler pattern used in base handlers
function aroundHandler( event, targetAction, eventArguments, rc, prc ) {
    
    try{

        // prepare arguments for action call
        var args = {
            event = arguments.event,
            rc    = arguments.rc,
            prc   = arguments.prc
        };

        structAppend( args, eventArguments );

        // execute the action now
        return arguments.targetAction( argumentCollection=args );

    // Catch 404 errors!
    } catch ( NotFound e ) {

        // option 1: Override the event (will bypass the event cache)
        event.overrideEvent( "errors.onMissingPage" ); // bypasses event cache on the current event
        
        // option 2: Set the event in the rc (will not bypass the event cache)
        rc.event = "errors.onMissingPage"; 
        
        return runEvent( 
            event = "errors.onMissingPage",
            eventArguments = {
                "exception": e
            }
        );

    }

}
```

For a missing page:

```cfc
"errors.onMissingPage": function( trail, event, rc, prc ) {
    trail.push( "Home", event.buildLink( "" ) )
         .push( "Page Not Found", "" );
}
```

Crumbs:

```json
[
    { "name": "Home", "link": "/" },
    { "name": "Page Not Found", "link": "" }
]
```

### More Examples

Check out the sample application in the `test-harness` folder.

## Roadmap

- Add support for `trail.push()` to accept aliases (e.g., `trail.push( "home" )`).
- Boxlang support 🤞
- More flexible error handling when configuration issues arise (e.g., bad rules, etc.).

## Contributing

Do you have any ideas for improving this module? Feel free to submit an issue or, even better, a pull request! Don't forget to add tests for your changes.

## About the Author

This module was created by [Angry Sam Productions](https://www.angrysam.com), a California-based web development company. We're passionate about giving back to the dev community through open source because we believe sharing knowledge builds a stronger, better-connected world.  If you're interested in contracting us for your next project or learning more, feel free to [reach out](https://www.angrysam.com/).

## Running Tests

To run the tests, simply run the following command from the root of the project in Commandbox:
`start server-lucee@5.json` (or whichever server JSON you want to use)
`server open` (to open the server in your browser)
navigate to `/tests/runner.cfm` in your browser.
