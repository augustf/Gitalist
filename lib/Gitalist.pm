package Gitalist;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

extends 'Catalyst';

use Catalyst qw/
                ConfigLoader
                Static::Simple
                StackTrace/;

our $VERSION = '0.01';

# Bring in the libified gitweb.cgi.
use gitweb;

__PACKAGE__->config(
    name => 'Gitalist',
    default_view => 'Default',
    default_model => 'Git', # Yes, we are going to be changing this.
);

# Start the application
__PACKAGE__->setup();

around uri_for => sub {
  my ($orig, $c) = (shift, shift);
  my $params = Catalyst::Utils::merge_hashes(
    { p => $c->model('Git')->project },
    ref($_[-1]) eq 'HASH' ? pop @_ : {}
  );
  (my $uri = $c->$orig(@_, $params))
    =~ tr[&][;];
  return $uri;
};

=head1 NAME

Gitalist - Catalyst based application

=head1 SYNOPSIS

    script/gitalist_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Gitalist::Controller::Root>, L<Catalyst>

=head1 AUTHORS AND COPYRIGHT

  Catalyst application:
    (C) 2009 Venda Ltd and Dan Brook <dbrook@venda.com>

  Original gitweb.cgi from which this was derived:
    (C) 2005-2006, Kay Sievers <kay.sievers@vrfy.org>
    (C) 2005, Christian Gierke

=head1 LICENSE

FIXME - Is this going to be GPLv2 as per gitweb? If so this is broken..

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;