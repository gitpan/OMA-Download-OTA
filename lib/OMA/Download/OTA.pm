package OMA::Download::OTA;
use strict;
=head1 NAME

OMA::Download::OTA - Perl extension for describing download descriptor objects according to OMA Download OTA 1.0 specification.

=head1 SYNOPSIS

  use OMA::Download::OTA;
  
  my $ota = OMA::Download::OTA->new(%properties);
  print $ota->mime."\n\n"
  print $ota->get();

  
=head1 DESCRIPTION

Complete implementation of the Open Mobile Alliance Download Over The Air 1.0 specification.


=head1 CONSTRUCTOR



=cut

BEGIN {
    $OMA::Download::OTA::VERSION = '1.00.04';
}

sub new {
    my ($class, %arg)=@_;
    my $self={
        properties => {
            name             => $arg{name},
            vendor           => $arg{vendor},
            type             => $arg{type},
            size             => $arg{size},
            description      => $arg{description},
            objectURI        => $arg{objectURI},
            installNotifyURI => $arg{installNotifyURI},
            nextURL          => $arg{nextURL},
            DDVersion        => '1.0',
            infoURL          => $arg{infoURL},
            iconURI          => $arg{iconURI},
            installParam     => $arg{installParam},
        },
        status => {
            900    =>    'Success',
            901    =>    'Insufficient memory',
            902    =>    'User Cancelled',
            903    =>    'Loss of Service',
            905    =>    'Attribute mismatch',
            906    =>    'Invalid descriptor',
            951    =>    'Invalid DDVersion',
            952    =>    'Device Aborted',
            953    =>    'Non-Acceptable Content',
            954    =>    'Loader Error'
        }
    };
    $self=bless $self, $class;
    $self;
}
=head1 PROPERTIES

=over 4

=item B<name> - Download Name

=cut
sub name {
    my ($self, $val)=@_;
    $self->{name} = $val if $val;
    $self->{name}
}

=item B<vendor> - Download Vendor Name

=cut
sub vendor {
    my ($self, $val)=@_;
    $self->{vendor} = $val if $val;
    $self->{vendor}
}

=item B<type> - Download Type

=cut
sub type {
    my ($self, $val)=@_;
    $self->{type} = $val if $val;
    $self->{type}
}

=item B<size> - Download File Size

=cut
sub size {
    my ($self, $val)=@_;
    $self->{size} = $val if $val;
    $self->{size}
}

=item B<description> - Download Description

=cut
sub description {
    my ($self, $val)=@_;
    $self->{description} = $val if $val;
    $self->{description}
}

=item B<objectURI> - Download Object URI

=cut
sub objectURI {
    my ($self, $val)=@_;
    $self->{objectURI} = $val if $val;
    $self->{objectURI}
}

=item B<installNotifyURI> - Intall notificatition URI 

=cut
sub installNotifyURI {
    my ($self, $val)=@_;
    $self->{installNotifyURI} = $val if $val;
    $self->{installNotifyURI}
}

=item B<nextURL> - Next URL 

=cut
sub nextURL {
    my ($self, $val)=@_;
    $self->{nextURL} = $val if $val;
    $self->{nextURL}
}

=item B<DDVersion> - Download descriptor version. Defaults to 1.0.

=cut
sub DDVersion {
    my ($self, $val)=@_;
    $self->{DDVersion} = $val if $val;
    $self->{DDVersion}
}

=item B<infoURL> - Donwload Info URL

=cut
sub infoURL {
    my ($self, $val)=@_;
    $self->{infoURL} = $val if $val;
    $self->{infoURL}
}

=item B<iconURI> - Download icon URI 

=cut
sub iconURI {
    my ($self, $val)=@_;
    $self->{iconURI} = $val if $val;
    $self->{iconURI}
}

=item B<installParam> - Intall Parameter

=cut
sub installParam {
    my ($self, $val)=@_;
    $self->{installParam} = $val if $val;
    $self->{installParam}
}

=item B<mime> - Returns the Download Descriptor MIME type 

=cut
sub mime {
    'application/vnd.oma.dd+xml'
}
=back

=head1 METHODS

=over 4

=item B<get> - Returns the Download Descriptor

=cut
sub get {
    my ($self)=@_;
    my $res='';
    for my $p (keys %{$self->{properties}}) {
        my $c = $self->{properties}{$p};
        if ($c) {
            if (ref $c eq 'ARRAY') {
                for my $c (@$c) {
                    $res.=_in_element($p, $c);
                }
            } else {
                $res.=_in_element($p, $c);
            }
        }
    }
    return '<media xmlns="http://www.openmobilealliance.org/xmlns/dd">'."\n".$res.'</media>'
}

## Private
sub _in_element {
    my ($element, $content)=@_;
    my $res='<'.$element;
    if ($content) {
        $res.='>'.$content.'</'.$element.'>'."\n"
    } else {
        $res.='/>'
    }
    $res;
}
1;
__END__

=back

=head1 SEE ALSO

OMA Download OTA Specifications

=head1 AUTHOR

Bernard Nauwelaerts, E<lt>bpgn@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Released under the GPL. See LICENCE for details.

Copyright (C) 2006 by Bernard Nauwelaerts

=cut
