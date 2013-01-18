log-warner4
===========

Almost typical log scraping script for nagios. If you have the time to define
the regexs, nothing (that gets logged) will escape your notice.

Some interesting bits:
    * Keeps track of where it last read it
    * Externally defined regexes to match against (use cos_evt, etc.)
    * You define what CRITICAL, WARN, and OK lines are
        ** Anything else will trigger an UNKNOWN alert
