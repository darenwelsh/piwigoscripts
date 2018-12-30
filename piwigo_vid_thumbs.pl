#!/usr/bin/perl

# author: Daren Welsh
# version: 1.0
#
# usage:
# perl piwigo_vid_thumbs.pl
#    --base_url=http://address/of/your/piwigo
#    --user=your_username
#    --password=your_password
#
# scheudle in cron:
# perl /directory/to/script/piwigo_vid_thumbs.pl --base_url=https://yoursite.com --user=cron --password=1234 

use strict;
use warnings;

# make it compatible with Windows, but breaks Linux
#use utf8;

use File::Find;
use Data::Dumper;
use File::Basename;
use LWP::UserAgent;
use JSON;
use Getopt::Long;
use Encode qw/is_utf8 decode/;
use Time::HiRes qw/gettimeofday tv_interval/;
use Digest::MD5 qw/md5 md5_hex/;

my %opt = ();
GetOptions(
    \%opt,
    qw/
          base_url=s
          username=s
          password=s
      /
);

#my $album_dir = $opt{directory};
#$album_dir =~ s{^\./*}{};

our $ua = LWP::UserAgent->new;
$ua->agent('Mozilla/piwigo_vid_thumbs.pl 1.00');
$ua->cookie_jar({});

my %conf;
my %conf_default = (
    base_url => 'http://localhost:81/piwigogit',
    username => 'plg',
    password => 'plg',
);

foreach my $conf_key (keys %conf_default) {
    $conf{$conf_key} = defined $opt{$conf_key} ? $opt{$conf_key} : $conf_default{$conf_key}
}

$ua->default_headers->authorization_basic(
    $conf{username},
    $conf{password}
);

my $result = undef;
my $query = undef;

binmode STDOUT, ":encoding(utf-8)";

# Login to Piwigo
piwigo_login();

piwigo_refresh();

#---------------------------------------------------------------------
# Functions
#---------------------------------------------------------------------

sub piwigo_login {
    $ua->post(
        $conf{base_url}.'/ws.php?format=json',
        {
            method => 'pwg.session.login',
            username => $conf{username},
            password => $conf{password},
        }
    );
}

sub piwigo_refresh {
	$ua->post(
		$conf{base_url}.'/admin.php?page=plugin&section=piwigo-videojs/admin/admin.php&tab=sync',
		{
			mediainfo => '',
      ffmpeg => '/dir/to/your/ffmpeg/ffmpeg-git-20180418-64bit-static/ffmpeg',
			#metadata => 0,
      poster => 1,
      postersec => 4,
      #posteroverwrite => 0,
      output => 'jpg',
      thumbsec => 5,
      thumbsize => '120x68',
      #posteroverlay => 0,
      #thumb => 0,
			#simulate => $conf{simulate},
			'subcats_included' => 1,#$conf{subcat},
			submit => 1,
		}
	);
}
