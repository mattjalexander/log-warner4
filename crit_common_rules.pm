package crit_common_rules;
use warnings;
use strict;

sub crit_common_rules {
  return ( /OutOfMemory/i || /SEVERE:? / || /ERROR:? / ||
           / FATAL:? / || / CRITICAL:? / ||
           /^.*ERROR.*- An error occured reading a cache file - renaming$/ );
} 

1;
