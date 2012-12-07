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

 = 0;
 = 0;
#print "PATH\tUID\t\t\t\t\tDM-ID\tSIZE\t\tACTIVE\tRESULT\n";
printf ("%-16s%-40s%-10s%-10s%-10s%-10s\n", "PATH", "UID", "DM-ID", "SIZE", "ACTIVE", "RESULT");
while(<STDIN>) {
        my () = mpath_devlist/;
        chomp();
        if(  =~ /^[a-zA-Z]/ ) {
                my(  ) = ;
                /^(\w*) \((\w*)\)\s*(dm-\d*)/;
                if(  > 0 ) {
                         = " of 4";
                        printf("%-10s",);
                        if(  == 4) {
                                print  color 'bold green'; printf("%-10s", "OK"); print color 'reset'; print "\n";
                        } else {
                                print color 'bold red'; printf("%-10s", "PROBLEM"); print color 'reset'; print "\n";
                        }
                         = 0;
                }
                my () = ;
                my ()  = ;
                my () = ;
                printf( "%-16s%-40s%-10s", ,,);
                 += 1;
        }
        if (  =~ m/^\[(.*?)\]/ ) {
                printf("%-10s", );
        }
        if (  =~ /^\s\_.*active\]\[ready/ ) {
                 += 1;
        }
}
if(  > 0 ) {
         = " of 4";
        printf("%-10s", );
        if(  == 4) {
                print  color 'bold green'; printf("%-10s","OK"); print color 'reset'; print "\n";
        } else {
                print color 'bold red'; printf("%-10s","PROBLEM"); print color 'reset'; print "\n";
        }

         = 0;
}
print color 'reset';
print "\n";
print "Found  paths\n";
exit 0;
