#==========================================================================
#              Copyright (c) 1995-1998 Martien Verbruggen
#--------------------------------------------------------------------------
#
#	Name:
#		Chart::PNGgraph::utils.pm
#
#	Description:
#		Package of general utilities.
#
# $Id: utils.pm,v 1.1.1.1.2.2 1999/10/07 21:04:01 sbonds Exp $
#
#==========================================================================
 
package Chart::PNGgraph::utils;

use strict qw(vars subs refs);

use vars qw( @EXPORT_OK %EXPORT_TAGS );
require Exporter;

@Chart::PNGgraph::utils::ISA = qw( Exporter );
 
@EXPORT_OK = qw( _max _min _round );
%EXPORT_TAGS = ( all => [qw(_max _min _round)],);

$Chart::PNGgraph::utils::prog_name    = 'Chart::PNGgraph::utils.pm';
$Chart::PNGgraph::utils::prog_rcs_rev = '$Revision: 1.1.1.1.2.2 $';
$Chart::PNGgraph::utils::prog_version = 
	($Chart::PNGgraph::utils::prog_rcs_rev =~ /\s+(\d*\.\d*)/) ? $1 : "0.0";

{
    sub _max { 
        my ($a, $b) = @_; 
		return undef	if (!defined($a) and !defined($b));
		return $a 		if (!defined($b));
		return $b 		if (!defined($a));
        ( $a >= $b ) ? $a : $b; 
    }

    sub _min { 
        my ($a, $b) = @_; 
		return undef	if (!defined($a) and !defined($b));
		return $a 		if (!defined($b));
		return $b 		if (!defined($a));
        ( $a <= $b ) ? $a : $b; 
    }

    sub _round { 
        my($n) = shift; 
		sprintf("%.0f", $n);
    }

    sub version {
        $Chart::PNGgraph::utils::prog_version;
    }

    $Chart::PNGgraph::utils::prog_name;

} # End of package MVU
