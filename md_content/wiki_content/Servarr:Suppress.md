When a user with the 'deleterevision' permission (see Enabling section) views a history page, they will see an extra button on the page that says "Change visibility of selected revisions". They will also see checkboxes next to all the revision entries on the page. If they select one or more revisions and click the button, they will be presented with an interface allowing them to do any of the following:

Hide revision text from users Hide edit summary from users Hide editor's username/IP address from users If they have the 'suppressrevision' permission, they will also be able to hide the information from sysops.

Similar functionality is also provided for log entries. The equivalent permissions are 'deletelogentry' and 'suppressionlog'.

Deleted revisions and events will still appear in the page history and logs, but parts of their content will be inaccessible to regular users.

For the technical part of this feature, see Bitfields for rev deleted.

Enabling To enable it, you have to set some user rights in LocalSettings.php.

Example:

To enable Sysops to hide revisions and log items from users: $wgGroupPermissions\['sysop'\]\['deletelogentry'\] = true; $wgGroupPermissions\['sysop'\]\['deleterevision'\] = true; To enable Oversighters to hide usernames from users and Sysops: $wgGroupPermissions\['oversight'\]\['hideuser'\] = true; To enable Oversighters to hide revisions and log items from users and Sysops: $wgGroupPermissions\['oversight'\]\['suppressrevision'\] = true; $wgGroupPermissions\['oversight'\]\['suppressionlog'\] = true; To enable Observers to view revisions and log items hidden from users and Sysops: MediaWiki version: ≥ 1.24

Gerrit change 139277 $wgGroupPermissions\['observers'\]\['viewsuppressed'\] = true; To assign the 'oversight' rights to users, log in as the site bureaucrat (Only bureaucrats can assign this role to other users, usually user with id \#1 has it by default) and go to Special:UserRights. Enter the name of the user that you wish to make an Oversighter, and then check the "oversight" box. See Manual:User rights for more information.

On some wikis the group name suppress is used instead of oversight.
