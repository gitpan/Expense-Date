package Expense::Date;

use strict;
use feature ':5.10';

=head1 NAME

Expense::Date - The great new Expense::Date!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Expense::Date;

    my $foo = Expense::Date->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 isTomorrow
=cut

sub isTomorrow {
    my $self = shift;
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = @$self;

    if ($hour >= 0 and $hour <= 6) {
        return 0;
    }
    else {
        return 1;
    }
}

=head2 new
=cut

sub new {
    my $class = shift;
    if (@_ == 3) {
        my $year = $_[0] - 1900;
        my $mon  = $_[1] - 1;
        my $day  = $_[2];
        return bless [0,0,0,$day,$mon,$year,0,0,0], $class;
    }

    if (@_ == 1) {
        my @date = split /\./, shift;
        my $year = $date[0] - 1900;
        my $mon  = $date[1] - 1;
        my $day  = $date[2];
        return bless[0,0,0,$day,$mon,$year,0,0,0], $class;
    }

    bless [@_], $class;
}

=head2 now
=cut

sub now {
    return Expense::Date->new(localtime);
}

=head2 f
=cut

sub f {
    my ($year, $month) = @_;
    return $year-1 if $month <= 2;
    return $year;
}

=head2 g
=cut

sub g {
    my $month = shift;
    return $month+13 if $month <= 2;
    return $month+1;
}

=head2 is_leap_year
=cut

sub is_leap_year {
    my $year = shift;
    ($year % 4 == 0) && ($year % 100 != 0) || ($year % 400 == 0);
}

=head2 to
=cut

sub to {
    my ($self, $other) = @_;
    my $n1 = 1461 * f($self->year, $self->month) / 4 + 153 * g($self->month) / 5 + $self->day;
    my $n2 = 1461 * f($other->year, $other->month) / 4 + 153 * g($other->month) / 5 + $other->day;

    return int ($n2 - $n1);
}

=head2 from
=cut

sub from {
    my ($self, $other) = @_;
    return $other->to($self);
}

=head2 yesterday
=cut

sub yesterday {
    my $self = shift;
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = @$self;
    if ($mday == 1) {
        if (($mon+1) == 1) {
            $mon  = 11;
            $mday = 31;
            return;
        }
        elsif (($mon+1) ~~ (5,7,8,10,12)) {
            $mday = 30;
        }
        elsif (($mon+1) == 3) {
            if (is_leap_year($year + 1900)) {
                $mday = 29;
            }
            else {
                $mday = 28;
            }
        }
        else {
            $mday = 31;
        }
        $mon--;
    }
    else {
        $mday--;
    }

    return Expense::Date->new($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
};

=head2 show
=cut

sub show {
    my $self = shift;
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)  = @$self;
    $year += 1900;
    $mon  += 1;

    return "$year.$mon.$mday";
}

=head2 get
=cut

sub get {
    my $self = shift;
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = @$self;
    $year += 1900;
    $mon  += 1;

    return ($year, $mon, $mday);
}

=head2 year
=cut

sub year {
    my $self = shift;
    ($self->get)[0];
    
}

=head2 month
=cut

sub month {
    my $self = shift;
    ($self->get)[1];
}

=head2 day
=cut

sub day {
    my $self = shift;
    ($self->get)[2];
}


=head1 AUTHOR

STKEVIN, C<< <zard1989 at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-expense-date at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Expense-Date>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Expense::Date


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Expense-Date>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Expense-Date>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Expense-Date>

=item * Search CPAN

L<http://search.cpan.org/dist/Expense-Date/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 STKEVIN.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Expense::Date
