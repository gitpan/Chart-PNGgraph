# This -*- perl -*- script makes the Makefile
# $Id: Makefile.PL,v 1.1.1.1.2.2 1999/10/07 21:01:55 sbonds Exp $
 
#--- Distribution section ---
 
$MODNAME = 'PNGgraph';
 
BEGIN { require 5.001 }
 
use ExtUtils::MakeMaker;
 
my @clean = qw(*% *.html *.b[ac]k *.old .[A-z]* tags);
push @clean, map { "*/$_" } @clean;
 
WriteMakefile(
		'VERSION_FROM'		=> 'lib/Chart/' . $MODNAME . '.pm',	#finds $VERSION
	      'DISTNAME'  		=> "Chart-$MODNAME",
	      'NAME'      		=> "Chart::$MODNAME",

		($] >= 5.005 ?
			('ABSTRACT'		=> 'Produces PNG graph plots',
			 'AUTHOR'		=> 'Martien Verbruggen (mgjv@comdyn.com.au)',
			) : ()
		),

		'PREREQ_PM'			=> { 'GD' => "1.20", },
 
        'dist'    			=> {
			'COMPRESS' 		=> 'gzip -9f',
			'SUFFIX'   		=> 'gz', 
		},
 
        'clean'   => { 'FILES' => join(" ", @clean), },
);

