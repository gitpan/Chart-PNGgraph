#==========================================================================
#			   Copyright (c) 1995-1998 Martien Verbruggen
#--------------------------------------------------------------------------
#
#	Name:
#		Chart::PNGgraph::linespoints.pm
#
# $Id: linespoints.pm,v 1.1.1.1.2.2 1999/10/07 21:04:01 sbonds Exp $
#
#==========================================================================

package Chart::PNGgraph::linespoints;
 
use strict qw(vars refs subs);
 
use Chart::PNGgraph::axestype;
use Chart::PNGgraph::lines;
use Chart::PNGgraph::points;
 
# Even though multiple inheritance is not really a good idea,
# since lines and points have the same parent class, I will do it here,
# because I need the functionality of the markers and the line types

@Chart::PNGgraph::linespoints::ISA = qw( Chart::PNGgraph::lines Chart::PNGgraph::points );

{
	sub initialise()
	{
		my $s = shift;

		$s->Chart::PNGgraph::lines::initialise();
		$s->Chart::PNGgraph::points::initialise();
	}

	# PRIVATE

	sub draw_data_set($$$) # GD::Image, \@data, $ds
	{
		my $s = shift;
		my $g = shift;
		my $d = shift;
		my $ds = shift;

		$s->Chart::PNGgraph::points::draw_data_set( $g, $d, $ds );
		$s->Chart::PNGgraph::lines::draw_data_set( $g, $d, $ds );
	}

	sub draw_legend_marker($$$$) # (GD::Image, data_set_number, x, y)
	{
		my $s = shift;
		my $g = shift;
		my $n = shift;
		my $x = shift;
		my $y = shift;

		$s->Chart::PNGgraph::points::draw_legend_marker($g, $n, $x, $y);
		$s->Chart::PNGgraph::lines::draw_legend_marker($g, $n, $x, $y);
	}

} # End of package Chart::PNGgraph::linesPoints

1;
