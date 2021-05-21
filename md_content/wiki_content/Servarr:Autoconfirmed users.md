Autoconfirmed users are wiki users who are members of the “Autoconfirmed
users” user group. This is a special user group which is allocated
automatically based on certain criteria.

The criteria are:

$wgAutoConfirmAge (number of seconds account needs to have existed to
qualify) $wgAutoConfirmCount (number of edits account needs to have to
qualify) BOTH criteria need to be satisfied for an account to be
automatically promoted to the “Autoconfirmed users” user group. What
rights autoconfirmed users have is controlled via $wgGroupPermissions.
By default, autoconfirmed users may:

Not be affected by IP-based rate limits, i.e. not be considered
“newbies” for purposes of User::isNewbie() and Manual:$wgRateLimits
(autoconfirmed) Edit pages protected as "Allow only autoconfirmed users"
(editsemiprotected) Move pages (move) You may override these via
$wgGroupPermissions.
