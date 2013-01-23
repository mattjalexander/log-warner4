package common_nohup_rules;
use warnings;
use strict;

sub common_nohup_rules {


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

1;
package ca6_agent;
use warnings;
use strict;

sub ca6_agent_crit {
  my $to_return='';
  my $timestamp="[0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}";

  if ($_ =~ /(OutOfMemory)/i || /SEVERE:? / ||
           / FATAL:? / || / CRITICAL:? / ||
           /^.*ERROR.*- An error occured reading a cache file - renaming$/
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


sub ca6_agent_warn {
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



sub ca6_agent_ignore {

my $timestamp="[0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}";

return ( $_ =~ /^($timestamp)\s*(INFO|DEBUG)\s*/

|| /^START/

|| /^($timestamp)\s*WARN\s*\[Generator-\d+\]\s*SMTPMessageGenerator\s+- Unable to generate content\. \[Illegal whitespace in address\]/

|| /^($timestamp)\s*WARN\s*\[Generator-\d+\]\s*SMTPMessageGenerator\s+- Unable to generate content\. \[Illegal character in domain\]/

|| /^($timestamp)\s*WARN\s*\[Generator-\d+\]\s*SMTPMessageGenerator\s+- Unable to generate content\. \[Missing domain\]/

|| /^($timestamp)\s*WARN\s*\[Generator-\d+\]\s*SMTPMessageGenerator\s+- Unable to generate content\. \[Illegal address\]/

|| /^($timestamp)\s*WARN\s*\[Generator-\d+\]\s*SMTPMessageGenerator\s+- Unable to generate content\. \[Illegal semicolon, not in group\]/

|| /^($timestamp)\s*WARN\s*\[Generator-\d+\]\s*SMTPMessageGenerator\s+- Unable to generate content\. \[Missing '[<>]'\]/

|| /^($timestamp)\s*WARN\s*\[Generator-\d+\]\s*SMTPMessageGenerator\s+- Unable to generate content\. \[Missing '[\(\)]'\]/



|| /^($timestamp)\s*WARN\s*\[Sender-\d+\]\s*SMTPMessageSender.*- Fatal send failure - discarding message to/


|| /^($timestamp)\s*WARN\s*\[Generator-\d+\]\s*SMTPMessageGenerator\s+- org.apache.velocity.runtime.exception.ReferenceException:.*is not a valid reference./

# OLD CA8 patterns that are no longer used since the agents have been replaced with COS
# new style (CA8) unknown bounce type message
#|| /^($timestamp)\s*WARN\s*\[Receiver-Thread-\d+\].*- Unable to get smtp bounce codes\.  Unexpected contentType/
#
#
#|| /^($timestamp)\s*WARN\s*\[Generator-[0-9]+] SMTPMessageGenerator\s*-\s*org\.apache\.velocity\.runtime\.exception\.ReferenceException: reference .* is not a valid reference\./
#
#|| /^($timestamp)\s*WARN\s*\[Receiver-Thread-[0-9]+\]SMTPUtils .* .* - Unable to process message with unexpected contentType \[/
#
#|| /^($timestamp)\s*WARN\s*\[Receiver-Thread-[0-9]+\]SMTPUtils .* .* - Unable to get address breakdown/
#
#|| /^($timestamp)\s*WARN\s*\[.*\]\s*SMTPConnectionHandler .* - Message format unrecognized: unable to receive message/
#
#|| /^($timestamp)\s*WARN\s*\[.*\]\s*SMTPConnectionHandler.* - Programming error: Unable to decode email address/
#|| /^($timestamp)\s*WARN\s*\[.*\]\s*SMTPConnectionHandler.* - Unknown processing error/
#|| /^($timestamp)\s*WARN\s*\[.*\]\s*SMTPConnectionHandler.* - Unable to construct MIME message from data/
#
# shutdown initiated
#|| /^($timestamp)\s*WARN \[.*\]\s*Agent\s*- Agent shutting down\.?/
#
# normal inbound agent shutdown
#|| /^($timestamp)\s*WARN \[.*\]\s*EmailReceiptManager\s*- Shutdown in progress\./
#|| /^($timestamp)\s*WARN \[.*\]\s*EmailReceiptManager\s*- No longer accepting inbound connections\.?/
#
# normal outbound agent shutdown
#|| /^($timestamp)\s*WARN \[.*\]\s*EmailDeliveryManager\s*- Shutdown in progress/
#|| /^($timestamp)\s*WARN \[.*\]\s*EmailQueueListener\s*- Shutdown in progress\./
#|| /^($timestamp)\s*WARN \[.*\]\s*EmailQueueListener\s*- No longer listening for new messages\./
#|| /^($timestamp)\s*WARN \[.*\]\s*ConfigurationFactory\s*- No configuration found/

)

}



1;
