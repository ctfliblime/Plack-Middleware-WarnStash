package Plack::Middleware::WarnStash;
use parent qw(Plack::Middleware);

# ABSTRACT: Overrides warn() handler to stuff warnings into $env

use strict;
use warnings;

our $VERSION = '0.001';

sub call {
    my ($self, $env) = @_;

    my $old_warn = $SIG{__WARN__} || sub { warn @_ };
    local $SIG{__WARN__} = sub {
        push @{$env->{'plack.middleware.warnstash.warnings'}}, @_;
        $old_warn->(@_);
    };

    $self->app->($env);
}

1;

__END__

=head1 NAME

Plack::Middleware::WarnStash

=head1 SYNOPSIS

  # app.psgi
  builder {
      enable 'WarnStash';
      enable 'Debug', panels => ['WarnLog'];
      $my_app;
  };

=head1 DESCRIPTION

Plack::Middleware::WarnStash overrides the warn() handler to copy the
contents of each warning into $env->{plack.middleware.warnstash.warnings}.
The warnings can then be viewed with the debug panel enabled via the
"Environment" tab or the Plack::Middleware::Debug::WarnLog tab.

=head1 AUTHOR

Clay Fouts E<lt>cfouts@khephera.netE<gt> (original author)

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Plack::Middleware::WarnStash> L<Plack::Middleware::Test::StashWarnings>

=cut
