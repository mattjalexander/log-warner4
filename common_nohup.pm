package common_nohup;
use warnings;
use strict;

sub common_nohup_ignore {


return ( 
# START line is required - part of internal processing
  /^START/ ||
  /^[0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}\s+(DEBUG|INFO|WARN).*$/ ||
  /^\s+at (com|sun|org|java|javax|net|oracle)\..*$/ ||
  /^\s*$/ ||
  /^Found (((Major|Minor) Version|Revision) [0-9]+|[0-9]+ pieces of version information)$/ ||
  /^Parsing .* for version information\.$/ ||
  /^Exception in thread "Receiver-Thread-[0-9]+" java\.lang\.StringIndexOutOfBoundsException: String index out of range: [0-9]+$/ ||
  /^Full thread dump Java HotSpot\(TM\) Server VM \([0-9.\-A-Za-z_]+ mixed mode\):$/

# ca6 kernel
|| /^Hibernate:/


); 
}

sub common_nohup_crit {
  my $to_return='';

  if ($_ =~ /(OutOfMemory)/i 
  ) {

   # parses out items in parenthesis for abridged versions of logs
   if ( $1 ) {
     for (my $i = 1; $i <= $#+; $i++) {
      $to_return = $to_return . " " . substr($_, $-[$i], $+[$i] - $-[$i]);
     }
   } else { $to_return=$_; }

   return $to_return;

  }
}


sub common_nohup_warn {
  my $to_return='';
  my $timestamp="[0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}";


# ONLY UNCOMMENT THIS ONCE THERE ARE RULES TO TRIGGER ON
#   if ( $1 ) {
#     for (my $i = 1; $i <= $#+; $i++) {
#      $to_return = $to_return . " " . substr($_, $-[$i], $+[$i] - $-[$i]);
#     }
#   } else { $to_return=$_; }

   return $to_return;

#  }
}



1;
