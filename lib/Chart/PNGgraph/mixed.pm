#==========================================================================
#			   Copyright (c) 1995-1998 Martien Verbruggen
#--------------------------------------------------------------------------
#
#	Name:
#		Chart::PNGgraph::mixed.pm
#
# $Id: mixed.pm,v 1.1.1.1.2.2 1999/10/07 21:04:01 sbonds Exp $
#
#==========================================================================

package Chart::PNGgraph::mixed;
 
use strict;
 
use Chart::PNGgraph::axestype;
use Chart::PNGgraph::lines;
use Chart::PNGgraph::points;
use Chart::PNGgraph::linespoints;
use Chart::PNGgraph::bars;
use Chart::PNGgraph::area;
 
# Even though multiple inheritance is not really a good idea, I will
# do it here, because I need the functionality of the markers and the
# line types We'll include axestype as the first one, to make sure
# that's where we look first for methods.

@Chart::PNGgraph::mixed::ISA = qw( 
	Chart::PNGgraph::axestype 
	Chart::PNGgraph::lines 
	Chart::PNGgraph::points 
);

my %Defaults = (
	default_type => 'lines',
	mixed => 1,
);

{
	sub initialise()
	{
		my $s = shift;

		$s->SUPER::initialise();

		my $key;
		foreach $key (keys %Defaults)
		{
			$s->set( $key => $Defaults{$key} );
		}

		$s->Chart::PNGgraph::lines::initialise();
		$s->Chart::PNGgraph::points::initialise();
		$s->Chart::PNGgraph::bars::initialise();
	}

	sub draw_data_set($$$) # GD::Image, \@data, $ds
	{
		my $s = shift;
		my $g = shift;
		my $d = shift;
		my $ds = shift;

		my $type = $s->{types}->[$ds-1] || $s->{default_type};

		# Try to execute the draw_data_set function in the package
		# specified by type
		#
		eval '$s->Chart::PNGgraph::'.$type.'::draw_data_set($g, $d, $ds)';

		# If we fail, we try it in the package specified by the
		# default_type, and warn the user
		#
		if ($@)
		{
			warn "Set $ds, unknown type $type, assuming $s->{default_type}\n";

			eval '$s->Chart::PNGgraph::'.
				$s->{default_type}.'::draw_data_set($g, $d, $ds)';
		}

		# If even that fails, we bail out
		#
		die "Set $ds: unknown default type $s->{default_type}\n" if $@;
	}
 
	sub draw_legend_marker($$$$) # (GD::Image, data_set_number, x, y)
	{
		my $s = shift;
		my $g = shift;
		my $ds = shift;
		my $x = shift;
		my $y = shift;

		my $type = $s->{types}->[$ds-1] || $s->{default_type};

		eval '$s->Chart::PNGgraph::'.$type.'::draw_legend_marker($g, $ds, $x, $y)';

		eval '$s->Chart::PNGgraph::'.
			$s->{default_type}.'::draw_legend_marker($g, $ds, $x, $y)' if $@;

	}

} # End of package Chart::PNGgraph::linesPoints

1;
