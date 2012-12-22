mpath_devlist
=============

A small perl script that parses the output of multipath -ll to list all the mpaths and the number of child paths connected.  Output based loosly on IBM's xiv_devlist

Useage is as follows:

    # multipath -ll | mpath_devlist.pl
