In MediaWiki 1.32 the rights for editing sitewide CSS, JS and JSON, and interface messages flagged as raw, were separated from the right to edit pages in the MediaWiki namespace. Users now need both editinterface and (respectively) editsitecss, editsitejs or editsitejson to be able to do so. The only user group that has all of those permissions by default is interface-admin.

Sitewide CSS/JS editing can be used to attack users of the site in various ways; it should be handed out with caution. (See m:Interface administrators for some advice.) In the case of CSS, for many use cases a safer alternative is provided by Extension:TemplateStyles.

More information about the change can be found in T190015.
