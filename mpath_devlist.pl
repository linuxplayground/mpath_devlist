#!/usr/bin/env perl

## mpath_devlist
##
## Simple perl script that parses the output of multipath -ll
## and displays the results with one line per path showing number
## of active paths to storage.

## Assumes that there are 4 paths to each mapped device and reports
## OK or PROBLEM if less than 4 paths are found.

## Author: David Latham <david@sitedesign.co.nz>
##         http://david-latham.blogspot.com

## License: GPL version 2

# vim:expandtab:ts=4:softtabstop=4:autoindent
use Term::ANSIColor;

$count = 0;
$pcount = 0;
#print "PATH\tUID\t\t\t\t\tDM-ID\tSIZE\t\tACTIVE\tRESULT\n";
printf ("%-16s%-40s%-10s%-10s%-10s%-10s\n", "PATH", "UID", "DM-ID", "SIZE", "ACTIVE", "RESULT");
while(<STDIN>) {
        my ($line) = $_;
        chomp($line);
        if( $line =~ /^[a-zA-Z]/ ) {
                my( $id ) = $1;
                /^(\w*) \((\w*)\)\s*(dm-\d*)/;
                if( $count > 0 ) {
                        $counttext = "$count of 4";
                        printf("%-10s",$counttext);
                        if( $count == 4) {
                                print  color 'bold green'; printf("%-10s", "OK"); print color 'reset'; print "\n";
                        } else {
                                print color 'bold red'; printf("%-10s", "PROBLEM"); print color 'reset'; print "\n";
                        }
                        $count = 0;
                }
                my ($pname) = $1;
                my ($puid)  = $2;
                my ($pdmid) = $3;
                printf( "%-16s%-40s%-10s", $pname,$puid,$pdmid);
                $pcount += 1;
        }
        if ( $line =~ m/^\[(.*?)\]/ ) {
                printf("%-10s", $1);
        }
        if ( $line =~ /^\s\\_.*active\]\[ready/ ) {
                $count += 1;
        }
}
if( $count > 0 ) {
        $counttext = "$count of 4";
        printf("%-10s", $counttext);
        if( $count == 4) {
                print  color 'bold green'; printf("%-10s","OK"); print color 'reset'; print "\n";
        } else {
                print color 'bold red'; printf("%-10s","PROBLEM"); print color 'reset'; print "\n";
        }

        $count = 0;
}
print color 'reset';
print "\n";
print "Found $pcount paths\n";
exit 0;
