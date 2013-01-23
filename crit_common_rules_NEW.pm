package crit_common_rules_NEW;
use warnings;
use strict;

sub crit_common_rules_NEW {
  my $to_return='';
  
  if ($_ =~ /(OutOfMemory)/i || /SEVERE:? / || /ERROR:? / ||
           / FATAL:? / || / CRITICAL:? / ||
           /^.*ERROR.*- An error occured reading a cache file - renaming$/ ) {

   if ( $1 ) { $to_return=$1; }
   else { $to_return=$_; }

   return $to_return;

  }
} 

1;
