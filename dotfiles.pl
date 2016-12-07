#!/usr/bin/perl
use strict;
use warnings;
use feature ":5.10";

use Data::Dumper;

# main
our %config = parse_config("./dotfiles_config");
print Dumper %config;

# main end

sub parse_config {
    my %config;
    my ($config_file) = @_;
    open CONFIG, $config_file || die "Can't open $config_file: $!";

    while (my $line = readline CONFIG) {
        chomp $line;
        if ($line =~ /^(?:\s*#.*)|(?:\s+)$/) {
            next;
        } elsif ($line =~ /^\[(.+)\]/) {
            my $section = lc $1;

            if ($section eq "general") {
                %{$config{$section}} = parse_hash(*CONFIG);
            } else {
                my @result = parse_list(*CONFIG);
                if ($section eq "directory") {
                    @result = map { normalize_dir($_) } @result;
                }
                @{$config{$section}} = @result;
            }
        } else {
            die "Syntax error in $config_file";
        }
    }

    close CONFIG;
    return %config;
}

sub parse_hash {
    my ($fh) = @_;
    my %kvs;
    while (my $line = readline $fh) {
        chomp $line;
        if ($line eq "") {
            return %kvs;
        } elsif ($line =~ /^(?:\s*#.*)$/) {
            next;
        } else {
            my ($key, $value) = split /\s*=\s*/, $line, 2;
            $kvs{$key} = $value;
        }
    }
}

sub parse_list {
    my ($fh) = @_;
    my @elms;
    while (my $line = readline $fh) {
        chomp $line;
        if ($line eq "") {
            return @elms;
        } elsif ($line =~ /^(?:\s*#.*)$/) {
            next;
        } else {
            push @elms, $line;
        }
    }
}

sub normalize_dir {
    my ($dir) = @_;
    if (substr($dir, -1) ne "/") {
        $dir = "$dir/";
    }
    return $dir;
}


}

