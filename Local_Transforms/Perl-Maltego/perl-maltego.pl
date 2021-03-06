#!/usr/bin/env perl
# The above shebang is for "perlbrew", otherwise replace with "/usr/bin/perl" and update the "use lib '[Insert CPAN Module Path]'" line.
#
# Please refer to the Plain Old Documentation (POD) at the end of this Perl Script for further information

# perltidy: 20121226

# Perl v5.8 is the minimum version required for 'use autodie'
# Perl v5.8.1 is the minimum version required for 'use utf8'
use 5.0080001;
use v5.8.1;

# use lib '[Insert CPAN Module Path]';

use warnings FATAL;
use diagnostics;

use utf8;

# TODO use autodie qw(:all);
use autodie;

# use Smart::Comments;

my $VERSION = "0.1_3"; # May be required to upload script to CPAN i.e. http://www.cpan.org/scripts/submitting.html

# http://ctas.paterva.com/view/Specification#Message_Wrapper
my $maltego_message_start_tag = "<MaltegoMessage>\n";
my $maltego_transform_response_message_start_tag =
  "\t<MaltegoTransformResponseMessage>\n";
my $ui_messages_start_tag           = "\t\t<UIMessages>\n";
my $ui_messages_end_tag             = "\t\t</UIMessages>\n";
my $ui_message_type_debug_start_tag = "\t\t\t<UIMessage MessageType=\"Debug\">";
my $ui_message_type_inform_start_tag =
  "\t\t\t<UIMessage MessageType=\"Inform\">";
my $ui_message_type_partial_error_start_tag =
  "\t\t\t<UIMessage MessageType=\"PartialError\">";
my $ui_message_type_fatal_error_start_tag =
  "\t\t\t<UIMessage MessageType=\"FatalError\">";
my $ui_message_end_tag = "</UIMessage>\n";

# http://ctas.paterva.com/view/Specification#Entity_definition
my $entities_start_tag = "\t\t<Entities>\n";

# TODO <Entity Type><Value> and <AdditionalFields>
my $entities_end_tag = "\t\t</Entities>\n";
my $maltego_transform_response_message_end_tag =
  "\t</MaltegoTransformResponseMessage>\n";
my $maltego_message_end_tag = "</MaltegoMessage>\n";

# sub trim() forked from http://my.safaribooksonline.com/book/programming/perl/1565922433/strings/ch01-34997
sub trim {
    my @trimmed = @_;
    foreach (@trimmed) {
        s/^\s+//;
        s/\s+$//;
        my $trimmed = $_;

        # "###" is for Smart::Comments CPAN Module
        ### \$trimmed is: $trimmed;
    }
    return wantarray ? @trimmed : $trimmed[0];
}

sub split_maltego_additional_fields {

    my $maltego_additional_field_values = $_[0];
    my @maltego_additional_field_values =
      split( '#', $maltego_additional_field_values );

    my %maltego_additional_field_values;

    foreach (@maltego_additional_field_values) {
        my ( $key, $value ) = split( /=/, $_, 2 );

        # "###" is for Smart::Comments CPAN Module
        ### \$key is: $key;
        ### \$value is: $value;
        $maltego_additional_field_values{"$key"} = "$value";

        # TODO perl-maltego.pl sub trim()
    }

    return %maltego_additional_field_values;
}

sub maltego_ui {
    if ( @_ < 2 ) {

        #TODO print DEBUG "@_ is less than 2";
        die();
    }
    my @uimessages = @_;
    print "$maltego_message_start_tag";
    print "$maltego_transform_response_message_start_tag";
    print "$ui_messages_start_tag";
    foreach my $uimessage (@uimessages) {

        # TODO Other UIMessage MessageType
        if ( $uimessage eq "Inform" ) {

            # TODO Check array element should be "odd" numbered;
            print $ui_message_type_inform_start_tag;
            next;
        }
        if ( $uimessage eq "Fatal Error" ) {

            # TODO Check array element should be "odd" numbered;
            print $ui_message_type_fatal_error_start_tag;
            next;
        }
        chomp $uimessage;
        print $uimessage;
        print $ui_message_end_tag;
    }
    print "$ui_messages_end_tag";
}

sub maltego_error_no_entities_to_return {
    print $entities_start_tag;
    print $entities_end_tag;
    maltego_message_end();
}

sub maltego_message_end {
    print $maltego_transform_response_message_end_tag;
    print $maltego_message_end_tag;
}

=head1 NAME

perl-maltego.pl

=head1 VERSION

This documentation refers perl-maltego.pl Alpha $VERSION

=head1 CONFIGURATION

Set the value(s) marked as #CONFIGURATION above this POD
    
=head1 USAGE

=head1 REQUIRED ARGUEMENTS
                
=head1 OPTIONAL ARGUEMENTS

=head1 DESCRIPTION

sub() {} for Maltego Transforms  

=head1 DEPENDENCIES

=head1 PREREQUISITES

=head1 COREQUISITES

=head1 INSTALLATION

=head1 OSNAMES

osx

=head1 SCRIPT CATEGORIES

Web

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

Please refer to the comments beginning with "TODO" in the Perl Code.

=head1 AUTHOR

Christian Heinrich

=head1 CONTACT INFORMATION

http://cmlh.id.au/contact

=head1 MAILING LIST

=head1 REPOSITORY

http://github.com/cmlh/

=head1 FURTHER INFORMATION AND UPDATES

http://cmlh.id.au/tagged/maltego

=head1 LICENSE AND COPYRIGHT

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. 

Copyright 2012 Christian Heinrich
